class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    before_action :gest_user_invalid, only: [:update]
    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if !@user.image.attached?
            image_path = Rails.root.join('app/assets/images/user_default.png')
            @user.image.attach(io: File.open(image_path), filename: 'user_default.png')
        end
        if @user.save
            log_in @user
            flash[:seccess] = 'ようこそ Ssへ' 
            redirect_to top_next_path
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "ユーザー設定を更新しました"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def gest_user_invalid
        redirect_to root_path  if current_user.email == "gest_user@user.com"
    end
end
