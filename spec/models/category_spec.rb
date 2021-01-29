require 'rails_helper'

RSpec.describe Category, type: :model do
	before do
		@category = FactoryBot.build(:category)
	end

	context '正常値の確認' do
		it "bodyがあれば有効" do
			expect(@category).to be_valid
		end
    end
	
	context '異常値の確認' do
		it "bodyが無ければ無効" do
			@category.name = nil
			expect(@category).to be_invalid
		end
	end
end
