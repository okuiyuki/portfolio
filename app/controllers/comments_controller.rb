class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy edit update]
  def create
    @comment = current_user.comments.new(comment_params)
    @post = @comment.post
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = 'コメントを投稿しました'
    else
      flash[:danger] = 'コメントの投稿に失敗しました'
    end
    redirect_to post_path(@comment.post_id)
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'コメントを削除しました'
    else
      flash[:danger] = 'コメントを削除できませんでした'
    end
    redirect_to post_path(@comment.post.id)
  end

  def edit
    @post = @comment.post
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'コメントを更新しました'
      redirect_to post_path(@comment.post.id)
    else
      render 'edit'
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
