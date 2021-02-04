class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update]

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
    redirect_to current_user
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を更新しました"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @post = Post.includes(images_attachments: :blob).find(params[:id])
    @user = @post.user
    @comments = @post.comments.includes(user: {image_attachment: :blob})
    @like = Like.new
    if logged_in?
    @comment = current_user.comments.new
    end
  end

  def index
    @posts = Post.includes(:liked_users).sort { |a,b| b.liked_users.size <=> a.liked_users.size }
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
  end

  private

  def post_params
    params.require(:post).permit(:title, :discription, :github_url, :app_url, :category_id, images: [])
  end

  #def correct_user
  #  @user = User.find(params[:id])
  #  redirect_to root_url unless current_user?(@user)
  #end

  #def correct_user
  #  @post = Post.find(params[:id])
  #  @user = @post.user
  #  redirect_to root_url unless current_user == @user
  #end
end
