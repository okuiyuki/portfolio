require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe 'GET /users/new' do

        it 'successを返す' do
            get new_user_path
            expect(response).to have_http_status(:success)
        end

        it 'レスポンスが200を返す' do
            get new_user_path
            expect(response.status).to eq 200
        end

    end

    describe 'POST /users' do

        context 'パラメーターが妥当' do
            it 'リクエストが成功' do
                post users_path, params: { user: FactoryBot.attributes_for(:user) }
                expect(response).to have_http_status(302)
            end
        end
        context 'パラメーターが異常' do
            it 'エラーメッセージの表示(email)' do
                post users_path, params: { user: FactoryBot.attributes_for(:user, email: "") }
                expect(response.body).to include "メールアドレスを入力してください"
            end
            
            it 'エラーメッセージの表示(name)' do
                post users_path, params: { user: FactoryBot.attributes_for(:user, name: "") }
                expect(response.body).to include "名前を入力してください"
            end

            it 'エラーメッセージの表示(password)' do
                post users_path, params: { user: FactoryBot.attributes_for(:user, password: "") }
                expect(response.body).to include "パスワードを入力してください"
            end

            it 'エラーメッセージの表示(password_confirmation)' do
                post users_path, params: { user: FactoryBot.attributes_for(:user, password_confirmation: "") }
                expect(response.body).to include "パスワード確認とパスワードの入力が一致しません"
            end

            it 'エラーメッセージの表示(パスワードの文字数)' do
                post users_path, params: { user: FactoryBot.attributes_for(:user, password: "pass", password_confirmation: "pass") }
                expect(response.body).to include "パスワードは6文字以上で入力してください"
            end
        end
    end


    describe '' do
    end
end
