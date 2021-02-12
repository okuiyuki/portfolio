require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #new' do
    it 'successを返す' do
      get new_user_path
      expect(response).to have_http_status(:success)
    end

    it 'レスポンスが200を返す' do
      get new_user_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメーターが妥当' do
      it 'リクエストが成功しリダイレクト' do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(:found)
      end
    end

    context 'パラメーターが異常' do
      it 'エラーメッセージの表示(email)' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, email: '') }
        expect(response.body).to include 'メールアドレスを入力してください'
      end

      it 'エラーメッセージの表示(name)' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, name: '') }
        expect(response.body).to include '名前を入力してください'
      end

      it 'エラーメッセージの表示(password)' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, password: '') }
        expect(response.body).to include 'パスワードを入力してください'
      end

      it 'エラーメッセージの表示(password_confirmation)' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, password_confirmation: '') }
        expect(response.body).to include 'パスワード確認とパスワードの入力が一致しません'
      end

      it 'エラーメッセージの表示(パスワードの文字数)' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, password: 'pass', password_confirmation: 'pass') }
        expect(response.body).to include 'パスワードは6文字以上で入力してください'
      end
    end
  end

  context 'ログインしていない場合' do
    before do
      @user = FactoryBot.create(:user)
      @user.image.attach(io: File.open('app/assets/images/user_default.png'), filename: 'user_default.png')
    end

    describe 'GET #show' do
      it 'successを返す' do
        get user_path(@user.id)
        expect(response).to have_http_status(:success)
      end

      it 'レスポンスが200,okを返す' do
        get user_path(@user.id)
        expect(response.status).to eq 200
      end
    end

    describe 'GET #edit' do
      it 'ログイン画面へリダイレクト' do
        get edit_user_path(@user.id)
        expect(response).to redirect_to login_url
      end
    end

    describe 'PATCH #update' do
      it 'ログイン画面へリダイレクト' do
        patch user_path(@user.id), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to login_url
      end
    end
  end

  context 'ログインしている場合' do
    before do
      @user = FactoryBot.create(:user)
      @user.image.attach(io: File.open('app/assets/images/user_default.png'), filename: 'user_default.png')
      post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
    end

    describe 'GET #edit' do
      it 'succsessを返す' do
        get edit_user_path(@user.id)
        expect(response).to have_http_status(:success)
      end

      it 'レスポンスが200,okを返す' do
        get edit_user_path(@user.id)
        expect(response.status).to eq 200
      end
    end

    describe 'PATCH #update' do
      it 'successを返す' do
        patch user_path(@user.id), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to @user
      end
    end
  end
end
