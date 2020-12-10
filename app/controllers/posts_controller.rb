class PostsController < ApplicationController
  def new
    @post = current_user.posts.build
  end
end
