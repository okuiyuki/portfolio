module ApplicationHelper

    def get_twitter_card_info(post)
        twitter_card = {}
        if post
            twitter_card[:url] = "localhost:3000/posts/#{post.id}"
            twitter_card[:title] = "おすすめ"
            twitter_card[:discription] ="タイトル #{post.title}"
            post_image = post.images[0]
            twitter_card[:image] = post_image
        else
            twitter_card[:url] = "localhost:3000"
            twitter_card[:title]  = "アプリ"
            twitter_card[:discription] = "タイトル"
            twitter_card[:image] = "https://webdesign-trends.net/wp/wp-content/uploads/2020/07/free-illustrations-2020.png"
        end
        twitter_card[:card] = "summary"
        twitter_card[:site] = @ZerygDVYc7IjvaU
    end
end
