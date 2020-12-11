module SessionsHelper
    #ログインする
    def log_in(user)
        session[:user_id] = user.id
    end

    #ログインしているユーザーが戻り値
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    #ログインしているか？
    def logged_in?
        !current_user.nil?
    end

    #ログアウト
    def logout
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    #ユーザーのセッションを永続化する
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    #ユーザーのセッションを消去する
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    #ログイン済みのユーザーか確認とurl記憶
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = 'Please log in'
            redirect_to login_url
        end
    end

    #urlを覚えておく
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    #指定のurlもしくはsessionに覚えたurlにリダイレクト
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url || default ])
        session.delete(:forwarding_url)
    end

    def current_user?(user)
        user == current_user
    end
end
