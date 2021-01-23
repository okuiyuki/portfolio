require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /" do
    it "successを返す" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "リクエストが200,OKを返す" do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /top_next' do
    it 'successを返す' do
      get top_next_path
      expect(response).to have_http_status(:success)
    end

    it 'リクエストが200,OKを返す' do
      get top_next_path
      expect(response.status).to eq 200
    end
  end
end
