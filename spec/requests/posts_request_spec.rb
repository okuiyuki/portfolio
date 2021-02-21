require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'ログインしていない場合' do
    let(:post1) { FactoryBot.create(:post) }

    describe 'GET #new' do
      it 'ログイン画面にリダイレクト' do
        get new_post_path
        expect(response).to redirect_to login_url
      end
    end

    describe 'POST #create' do
      it 'ログイン画面にリダイレクト' do
        post posts_path
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET #edit' do
      it 'ログイン画面にリダイレクト' do
        get edit_post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'PATCH #update' do
      it 'ログイン画面にリダイレクト' do
        patch post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'DELETE #destroy' do
      it 'ログイン画面にリダイレクト' do
        delete post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET #show' do
      before do
        post1.user.image.attach(io: File.open('app/assets/images/user_default.png'), filename: 'user_default.png')
      end

      it 'successを返す' do
        get post_path(post1.id)
        expect(response).to have_http_status(:success)
      end

      it 'リクエストが200, OKを返す' do
        get post_path(post1.id)
        expect(response.status).to eq 200
      end
    end
  end

  context 'ログインしている場合' do
    before do
      @user = FactoryBot.create(:user)
      post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
      @post = FactoryBot.create(:post, user_id: @user.id)
    end

    describe 'GET #new' do
      it 'successを返す' do
        get new_post_path
        expect(response).to have_http_status(:success)
      end

      describe 'POST #create' do
        it 'postの保存成功' do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, category_id: @post.category_id, tag_ids: '') }
          expect(response).to redirect_to @user
        end
      end

      it 'レスポンスが200,okを返す' do
        get new_post_path
        expect(response.status).to eq 200
      end
    end

    describe 'GET #edit' do
      it 'successを返す' do
        get edit_post_path(@post.id)
        expect(response).to have_http_status(:success)
      end

      it 'レスポンスが200,okを返す' do
        get edit_post_path(@post.id)
        expect(response.status).to eq 200
      end
    end

    describe 'PATCH #update' do
      it 'posts/showにリダイレクト' do
        patch post_path(@post.id), params: { post: FactoryBot.attributes_for(:post) }
        expect(response).to redirect_to @post
      end
    end

    describe 'DELETE #destroy' do
      it 'users/showにリダイレクト' do
        delete post_path(@post.id)
        expect(response).to redirect_to @user
      end

      it 'post削除される' do
        expect { delete post_path(@post.id) }.to change(Post, :count).by(-1)
      end
    end
  end
end
