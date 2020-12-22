class StaticPagesController < ApplicationController
  def home
  end

  def next
    if params[:search] == ""
      @posts = Post.all
    elsif params[:search]
      split_search = params[:search].split(/[[:blank:]]+/)
      @posts = []

      split_search.each do |search|
        next if search == ""
        @posts += Post.where(['discription LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%"])
      end
      @posts.uniq!
    else
      @posts = Post.all
    end
    @search = params[:search]
  end
end
