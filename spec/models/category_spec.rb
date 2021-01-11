require 'rails_helper'

RSpec.describe Category, type: :model do
	before do
		@category = Category.new(
			id: 1,
			name: "フロントエンド"
		)
	end

	it "bodyがあれば有効" do
		expect(@category).to be_valid
	end

	
end
