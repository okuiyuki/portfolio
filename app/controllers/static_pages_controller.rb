class StaticPagesController < ApplicationController
  def home
  end

  def next
    @posts = Post.all
  end
end
