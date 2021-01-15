require 'rails_helper'

RSpec.describe Post, type: :model do

    before do
        @post = FactoryBot.create(:post)
    end

    it '全ての値があるとき有効' do
        expect(@post).to be_valid
    end
    
    it "app_url, github_urlがなくても有効" do
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
        expect{@post.user.destroy}.to change{Post.count}.by(-1)
    end
end
