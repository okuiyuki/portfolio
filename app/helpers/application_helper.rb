module ApplicationHelper

    def get_twitter_card_info(post)
        post_image = post.images[0]
        twitter_card = []
        if post
            twitter_card[:url] = "http://localhost:3000/posts/#{post.id}"
            twitter_card[:title] = "おすすめ"
            twitter_card[:discription] ="タイトル #{post.title}"
            twitter_card[:image] = post_image
        else
            twitter_card[:url]
            twitter_card[:title]
            twitter_card[:discription]
            twitter_card[:image]
        end
        twitter_card[:card] = "summary"
        twitter_card[:site] = @ZerygDVYc7IjvaU
    end
end
