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
            twitter_card[:url] = "http://localhost:3000"
            twitter_card[:title]  = "アプリ"
            twitter_card[:discription] = "タイトル"
            twitter_card[:image] = "http://localhost:3000/assets/images/user_default.png"
        end
        twitter_card[:card] = "summary_large_image"
        twitter_card[:site] = @ZerygDVYc7IjvaU
        twitter_card
    end

    def string_extraction_limit(string, limit)
        string[0, limit]
    end

    # <% twitter_card = get_twitter_card_info(@post ? @post : nil) %>
    # <meta name="twitter:card" content=<%= twitter_card[:card] %> />
    # <meta name="twitter:site" content=<%= twitter_card[:site] %> />
    # <meta property="og:url" content=<%= twitter_card[:url] %> />
    # <meta property="og:title" content=<%= twitter_card[:title] %> />
    # <meta property="og:discription" content=<%= twitter_card[:discription] %> />
    # <meta property="og:image" content=<%= twitter_card[:image]%> />
    # <meta name="viewport" conten="width=device-width , initial-scale=1" />
end
