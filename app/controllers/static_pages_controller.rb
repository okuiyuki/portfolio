class StaticPagesController < ApplicationController
  def home
  end

  def next
    if (params[:search] == "") && (params[:category_id] == "")
      @posts = Post.all
    elsif params[:category_id] == ""
      split_search = params[:search].split(/[[:blank:]]+/)
      @posts = []

      split_search.each do |search|
        next if search == ""
        @posts += Post.where(['discription LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%"])
      end
      @posts.uniq!
    elsif params[:search] == ""
      @posts = Post.where(category_id: params[:category_id])
    else
      split_search = params[:search].split(/[[:blank:]]+/)
      @posts = []

      split_search.each do |search|
        next if search == ""
        @posts += Post.where(['(discription LIKE ? OR title LIKE ?) AND category_id', "%#{search}%", "%#{search}%", params[:category_id]])
      end
    end
    @search = params[:search]
    category = Category.find_by(id: params[:category_id])
    @category = category.name
  end
end
