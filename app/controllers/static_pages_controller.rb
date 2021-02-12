class StaticPagesController < ApplicationController
  def home
  end

  def next
    count_in_page = 5
    if (params[:search] == '') && (params[:category_id] == '')
      @posts = Post.page(params[:page]).includes(images_attachments: :blob, user: { image_attachment: :blob }).per(count_in_page)
    elsif params[:category_id] == ''
      split_search = params[:search].split(/[[:blank:]]+/)
      @posts = []
      split_search.each do |search|
        next if search == ''

        @posts += Post.where(['discription LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%"]).includes(images_attachments: :blob, user: { image_attachment: :blob })
      end
      @posts.uniq!
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(count_in_page)
    elsif params[:search] == ''
      @posts = Post.where(category_id: params[:category_id]).page(params[:page]).includes(images_attachments: :blob, user: { image_attachment: :blob }).per(count_in_page)
    elsif params[:search].present? && params[:category_id].present?
      split_search = params[:search].split(/[[:blank:]]+/)
      @posts = []
      split_search.each do |search|
        next if search == ''

        @posts += Post.where(['discription LIKE ? OR title LIKE ?', "%#{search}%", "%#{search}%"]).where(category_id: params[:category_id]).includes(images_attachments: :blob,
                                                                                                                                                     user: { image_attachment: :blob })
      end
      @posts.uniq!
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(count_in_page)
    else
      @posts = Post.page(params[:page]).includes(images_attachments: :blob, user: { image_attachment: :blob }).per(count_in_page)
    end
    @search = params[:search] if params[:search]
    # category = Category.find_by(id: params[:category_id]) if params[:category_id]
    # @category = category.name if params[:categroy_id]
    # @category_id = params[:category_id]
    @category_id = params[:category_id].to_i if params[:category_id].present?
  end
end
