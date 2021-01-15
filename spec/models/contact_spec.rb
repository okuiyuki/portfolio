require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    @contact = FactoryBot.create(:contact)
  end

  it 'name, messageがあれば有効' do
    expect(@contact).to be_valid
  end

  it 'nameが無ければ無効' do
    @contact.name = nil
    expect(@contact).to be_invalid
  end 

  it 'messageが無ければ無効' do
    @contact.message = nil
    expect(@contact).to be_invalid
  end

  it 'nameが50文字異常であれば無効' do
    @contact.name = "a" * 51
    expect(@contact).to be_invalid
  end

  it 'messageが500文字異常であれば無効' do
    @contact.message = "a" * 501
    expect(@contact).to be_invalid
  end
end
