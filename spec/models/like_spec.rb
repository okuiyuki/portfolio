require 'rails_helper'

RSpec.describe Like, type: :model do
    before do
        @like = FactoryBot.create(:like)
    end
    context '正常値の確認' do
        it 'post_id, user_idがあれば有効' do
            expect(@like).to be_valid
        end

        it 'post_idが同じでもuser_idが違えば有効' do
            user2 = FactoryBot.create(:user)
            expect(Like.create(user_id: user2.id, post_id: @like.post_id)).to be_valid
        end

        it 'user_idが同じでもpost_idが違えば有効' do
            post2 = FactoryBot.create(:post)
            expect(Like.create(user_id: @like.user_id, post_id: post2.id)).to be_valid
        end
    end

    context '異常値の確認' do
        it 'post_idが無ければ無効' do
            @like.post_id = nil
            expect(@like).to be_invalid
        end

        it 'user_idが無ければ無効' do
            @like.user_id = nil
            expect(@like).to be_invalid
        end

        it 'user_idとpost_idが同じものは無効' do
            expect(Like.create(user_id: @like.user_id, post_id: @like.post_id)).to be_invalid
        end

    end
end
