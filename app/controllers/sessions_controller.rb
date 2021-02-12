class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました'
      redirect_to top_next_url
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが違います'
      @email = params[:session][:email]
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end

  def gest_user
    gest_user = User.find_by(email: 'gest_user@user.com')
    if gest_user.nil?
      user = User.new(name: 'ゲストユーザー', email: 'gest_user@user.com', password: 'password', password_confirmation: 'password')
      image_path = Rails.root.join('app/assets/images/user_default.png')
      user.image.attach(io: File.open(image_path), filename: 'user_default.png')
      user.save
      log_in user
    else
      log_in gest_user
    end
    flash[:success] = 'ゲストユーザーとしてログインしました'
    redirect_to top_next_path
  end
end
