require 'rails_helper'

RSpec.describe Notification, type: :model do
    context '無効' do
        it 'visiter_idが無ければ無効' do
            expect{ FactoryBot.create(:notification, visiter_id: nil) }.to raise_error(ActiveRecord::NotNullViolation)
        end

        it 'visited_idが無ければ無効' do
            expect{ FactoryBot.create(:notification, visited_id: nil) }.to raise_error(ActiveRecord::NotNullViolation)
        end

        it 'actionがnilであれば無効' do
            expect{ FactoryBot.create(:notification, action: nil) }.to raise_error(ActiveRecord::NotNullViolation)
        end
    end

    context '有効' do
        it '必要な値がある時有効' do
            expect { FactoryBot.create(:notification) }.to change { Notification.count }.by(1)
        end

        it 'post_idがある時有効' do
            expect { FactoryBot.create(:notification, post_id: 1) }.to change { Notification.count }.by(1)
        end

        it 'comment_idがある時有効' do
            expect { FactoryBot.create(:notification, comment_id: 1) }.to change { Notification.count }.by(1)
        end
    end
end
