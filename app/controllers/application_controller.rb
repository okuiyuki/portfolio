class ApplicationController < ActionController::Base
  include SessionsHelper

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
