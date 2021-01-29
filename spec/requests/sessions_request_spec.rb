require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    describe 'GET  /login' do
            it "successを返す" do
            get login_path
            expect(response).to have_http_status(:success)
        end

        it "リクエストが200, OKを返す" do
            get login_path
            expect(response.status).to eq 200
        end
    end
end
