require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  describe 'GET #new' do
    it 'returns http success' do
      get new_contact_path
      expect(response).to have_http_status(:success)
    end

    it 'リクエストが200,OKになること' do
      get new_contact_path
      expect(response.status).to eq 200
    end

    it 'newテンプレートが表示されているか' do
      get new_contact_path
      expect(response.body).to include 'お問い合せ内容'
    end
  end

  describe 'POST #create' do
    context '有効な値送信' do
      it 'root_pathへリダイレクト' do
        post contacts_path, params: { contact: FactoryBot.attributes_for(:contact) }
        expect(response).to redirect_to root_path
      end
    end

    context '無効な値送信' do
      it 'nameが無ければrender' do
        post contacts_path, params: { contact: FactoryBot.attributes_for(:contact, name: '') }
        expect(response.body).to include 'お問い合わせの送信に失敗しました'
      end

      it 'messageが無ければrender' do
        post contacts_path, params: { contact: FactoryBot.attributes_for(:contact, message: '') }
        expect(response.body).to include 'お問い合わせの送信に失敗しました'
      end
    end
  end
end
