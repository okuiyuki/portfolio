require 'rails_helper'

RSpec.describe "Posts", type: :request do

  context 'ログインしていない場合' do
    let(:post1) { FactoryBot.create(:post)}

    describe 'GET /posts/new' do
      it 'ログイン画面にリダイレクト' do
        get new_post_path
        expect(response).to redirect_to login_url
      end
    end

    describe 'POST /posts' do
      it 'ログイン画面にリダイレクト' do
        post posts_path
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET /posts/:id/edit' do
      it 'ログイン画面にリダイレクト' do
        get edit_post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'PATCH /posts/:id' do
      it 'ログイン画面にリダイレクト' do
        patch post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'DELETE /posts/:id' do
      it 'ログイン画面にリダイレクト' do
        delete post_path(post1.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET /posts/:id' do
      it "successを返す" do
        get post_path(post1.id)
        expect(response).to have_http_status(:success)
      end

      it "リクエストが200, OKを返す" do
          get post_path(post1.id)
          expect(response.status).to eq 200
      end
    end



  end

  context 'ログインしている場合' do
  end

end
