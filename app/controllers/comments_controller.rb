class CommentsController < ApplicationController

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            flash[:success] = "コメントを投稿しました"
            redirect_to post_path(@comment.post_id)
        else
            flash[:danger] = "コメントの投稿に失敗しました"
            redirect_to post_path(@comment.post_id)
        end
    end

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end
end
