require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET #home' do
    it 'successを返す' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'リクエストが200,OKを返す' do
      get root_path
      expect(response.status).to eq 200
    end

    it 'homeテンプレートが表示される' do
      get root_path
      expect(response.body).to include "新規登録"
    end
  end

  describe 'GET #top_next' do
    it 'successを返す' do
      get top_next_path
      expect(response).to have_http_status(:success)
    end

    it 'リクエストが200,OKを返す' do
      get top_next_path
      expect(response.status).to eq 200
    end

    it 'top_nextテンプレートが表示される(search: nil, category_id: nil)' do
      get top_next_path
      expect(response.body).to include '投稿一覧'
    end

    it 'top_nextテンプレートが表示される(search: "search", category_id: nil)' do
      get top_next_path params: { search: "search" }
      expect(response.body).to include '投稿一覧'
    end

    it 'top_nextテンプレートが表示される(search: nil, category_id: 1)' do
      get top_next_path params: { category_id: 1 }
      expect(response.body).to include '投稿一覧'
    end

    it 'top_nextテンプレートが表示される(search: "search", category_id: 1)' do
      get top_next_path params: { search: "search", category_id: 1 }
      expect(response.body).to include '投稿一覧'
    end


  end
end
