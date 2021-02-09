require 'rails_helper'

RSpec.describe "Comments", type: :request do
    let(:comment) { FactoryBot.create(:comment)}

    context 'ログインしていない場合' do
        describe 'POST #create' do
            it 'current_userがnil' do
                expect{post post_comments_path(comment.post.id), params: { comment: FactoryBot.attrbutes_for(:comment)}}.to raise_error(NoMethodError)
            end
        end

        describe 'GET #edit' do
            it 'current_userがnil' do
                expect{get edit_post_comment_path(comment.post.id, comment.id)}.to raise_error(NoMethodError)
            end
        end

        describe 'PATCH #update' do
            it 'current_userがnil' do
                expect{patch post_comment(comment.post.id, comment.id), params: { comment: FactoryBot.attrbutes_for(:comment)}}.to raise_error(NoMethodError)
            end
        end

        describe 'DELETE #destroy' do
            it 'current_userがnil' do
                expect{delete post_comment(comment.post.id, comment.id)}.to raise_error(NoMethodError)
            end
        end
    end

    context 'ログインしている場合' do
        before do
            # @user = FactoryBot.create(:user)
            # post login_path, params: { session: FactoryBot.attributes_for(:user, email: @user.email) }
            # @post = FactoryBot.create(:post, user_id: @user.id)

            @comment = FactoryBot.create(:comment)
            post login_path, params: { session: FactoryBot.attributes_for(:user, email: @comment.user.email)}
        end

        describe 'POST #create' do
            it 'コメントしたpostにリダイレクト' do
                post post_comments_path(@comment.post.id), params: { comment: FactoryBot.attributes_for(:comment, user_id: @comment.user.id, post_id: @comment.post.id)}
                expect(response).to redirect_to post_path(@comment.post)
            end
        end

        describe 'GET #edit' do
            it 'successを返す' do
                get edit_post_comment_path(@comment.post.id, @comment.id)
                expect(response).to have_http_status(:success)
            end

            it 'レスポンスが200,okを返す' do
                get edit_post_comment_path(@comment.post.id, @comment.id)
                expect(response.status).to eq 200
            end
        end

        describe 'PATCH #update' do
            it 'コメントしたpostにリダイレクト' do
                patch post_comment_path(@comment.post.id, @comment.id), params: { comment: FactoryBot.attributes_for(:comment, user_id: @comment.user.id, post_id: @comment.post.id)}
                expect(response).to redirect_to @comment.post
            end
        end

        describe 'DELETE #destroy' do
            it 'コメントしたpostにリダイレクト' do
                delete post_comment_path(@comment.post.id, @comment.id)
                expect(response).to redirect_to @comment.post
            end

            it 'コメントの削除される' do
                expect{delete post_comment_path(@comment.post.id, @comment.id)}.to change { Comment.count }.by(-1)
            end
        end
    end
end
