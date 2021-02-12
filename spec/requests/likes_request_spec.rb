require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user_id: @user.id)
  end

  context 'ログインしていない場合' do
    describe 'POST #create' do
      it 'current_userがnil' do
        expect { post post_likes_path(@post) }.to raise_error(NoMethodError)
      end
    end

    describe 'DELETE #destroy' do
      it 'current_userがnil' do
        @like = FactoryBot.create(:like)
        expect { delete post_like_path(@like.post.id, @like.id) }.to raise_error(NoMethodError)
      end
    end
  end

  context 'ログインしている場合' do
    before do
      post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
    end

    describe 'POST #create' do
      it '保存成功' do
        expect { post post_likes_path(@post), params: { post_id: @post.id }, xhr: true }.to change(Like, :count).by(1)
      end
    end

    describe 'DELETE #destroy' do
      it 'current_userがnil' do
        @like = FactoryBot.create(:like, user_id: @user.id)
        expect { delete post_like_path(@like.post.id, @like.id), params: { post_id: @like.post.id, user_id: @user.id }, xhr: true }.to change(Like, :count).by(-1)
      end
    end
  end
end
