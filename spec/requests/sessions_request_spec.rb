require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    before do
        @user = FactoryBot.create(:user)
    end
    describe 'GET  #new' do
        it "successを返す" do
            get login_path
            expect(response).to have_http_status(:success)
        end

        it "リクエストが200, OKを返す" do
            get login_path
            expect(response.status).to eq 200
        end
    end


    describe 'POST #create' do
        it 'ログインの成功' do
            post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
            expect(response).to redirect_to "/top_next"
        end

        it 'ログインの失敗,email' do
            post login_path, params: { session: FactoryBot.attributes_for(:user) }
            expect(response.body).to include 'メールアドレスまたはパスワードが違います'
        end

        it 'ログインの失敗,password' do
            post login_path, params: { session: FactoryBot.attributes_for(:user, password: 'password1') }
            expect(response.body).to include 'メールアドレスまたはパスワードが違います'
        end
    end

    describe 'DELETE #destroy' do
        it 'ログアウト' do
            post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
            delete logout_path
            expect(response).to redirect_to root_path
        end
    end

    describe 'GET /gest_user' do
        it 'ゲストユーザーが無ければ作成してログイン成功' do
            get gest_user_path
            expect(response).to redirect_to "/top_next"
        end

        it 'ゲストユーザーがあればログイン成功' do
            User.create(name: "ゲストユーザー", email: "gest_user@user.com", password: "password", password_confirmation: "password")
            get gest_user_path
            expect(response).to redirect_to "/top_next"
        end
    end
    
end
