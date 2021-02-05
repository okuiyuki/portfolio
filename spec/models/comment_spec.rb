require 'rails_helper'

RSpec.describe Comment, type: :model do
    before do
        @comment = FactoryBot.create(:comment)
    end


    it "body, user_id, post_idがあれば有効" do
        expect(@comment).to be_valid
    end

    it "bodyが無ければ無効" do 
        @comment.body = ""
        expect(@comment).to be_invalid
    end

    it "user_idが無ければ無効" do
        @comment.user_id = nil
        expect(@comment).to be_invalid
    end

    it "post_idが無ければ無効" do
        @comment.post_id = nil
        expect(@comment).to be_invalid
    end

    it "bodyが255以上であれば無効" do 
        @comment.body = "a" * 256
        expect(@comment).to be_invalid
    end
end
