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


    def destroy
        @comment = current_user.comments.find(params[:post_id])
        if @comment.destroy
            flash[:success]  = "コメントを削除しました"
            redirect_to post_path(@comment.post.id)
        else
            flash[:danger] = "コメントを削除できませんでした"
            redirect_to  post_path(@comment.post.id)
        end
    end

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end
end
