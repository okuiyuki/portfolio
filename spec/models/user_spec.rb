require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe "validation" do
    it "name, emailがあれば登録できる" do
      expect(@user).to be_valid
    end

    it "nameがなければ無効" do
      @user.name = ""
      @user.valid?
      expect(@user.errors[:name]).to include("を入力してください")
    end

    it "emailが無ければ無効" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "passwordが5文字以下であれば無効" do
      @user.password = "a"* 5
      @user.valid?
      expect(@user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "passwordが6文字以上であれば有効" do
      @user.password = "a" * 6
      @user.password_confirmation = "a" * 6
      expect(@user).to be_valid
    end

    it "passwordとpassword_confirmationが一致しなければ無効" do
      @user.password_confirmation = "password1"
      expect(@user).to be_invalid
    end

    
  end


  


end
