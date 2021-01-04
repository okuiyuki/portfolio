class LikesController < ApplicationController

    def create
        @like = current_user.likes.build(post_id: params[:post_id])
        if @like.save
            redirect_to post_path(@like.post_id)
        else
            redirect_to root_path
        end
    end

    def destroy
        @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
        @like.destroy
        redirect_to post_path(@like.post_id)
    end
end
