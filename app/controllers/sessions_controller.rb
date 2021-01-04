class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
      flash[:success] = "ログインしました"
      redirect_back_or root_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが違います'
      @email = params[:session][:email]
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
