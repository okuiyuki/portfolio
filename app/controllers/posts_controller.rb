class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    redirect_to request.referrer || root_url
  end


  def post_params
    params.require(:post).permit(:title, :discription, :github_url, :app_url, :category_id)
  end

  def correct_user
    @user = User.find(id: params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
