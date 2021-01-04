require 'rails_helper'

RSpec.describe Post, type: :model do

    before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.build(:post, user_id: @user.id)
        Category.create(id: 1, name: "フロントエンド")
        @post.category_id = 1
    end

    it "title,discription,category_id,user_idがあれば有効" do
        @post.app_url = ""
        @post.github_url = ""
        expect(@post).to be_valid
    end

    it "titleが無ければ無効" do
        @post.title = ""
        @post.valid?
        expect(@post.errors[:title]).to include("を入力してください")
    end

    it "titleが50文字以上であれば無効" do
        @post.title = "a" * 51
        @post.valid?
        expect(@post.errors[:title]).to include("は50文字以内で入力してください")
    end

    it "discriptionが無ければ無効" do
        @post.discription = ""
        @post.valid?
        expect(@post.errors[:discription]).to include("を入力してください")
    end

    it "userが消えるとpostも消える" do
        @user.posts << @post
        expect{@user.destroy}.to change{Post.count}.by(-1)
    end
end
