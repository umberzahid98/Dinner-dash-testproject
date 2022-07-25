# require 'rails_helper'
# require_relative '../support/devise'
# RSpec.describe StoriesController, type: :controller do
#   describe "GET /" do
#     login_user
#     let(:user_post) { FactoryBot.create(:post)}
#     let(:params) { { post: { caption: user_post.caption ,images: user_post.images} } }
#     # create action
#     describe 'POST #create' do
#       before do
#         post :create, params: params
#       end
#       context 'when params are correct' do
#         it 'is expected to create new post  successfully' do
#           expect(assigns[:post]).to be_instance_of(Post)
#         end
#         it 'is expected to have user_id  assigned to it' do
#           expect(assigns[:post].user_id).to eq(subject.current_user.id)
#         end
#         it 'should return 200:OK' do
#           get :new
#           expect(response).to have_http_status(:success)
#         end
#         it 'is expected to have caption assigned to it' do
#           expect(assigns[:post].caption).to eq(params[:post][:caption])
#         end
#         it 'renders new template' do
#           is_expected.to render_template(:new)
#         end
#         it 'renders application layout' do
#           is_expected.to render_template(:application)
#         end
#         it 'check post has been added to database' do
#           expect(Post.all.size).to eq(1)
#         end
#         it 'actual post inserted' do
#           expect(Post.last).to eq(user_post)
#         end
#       end
#     end
#     # new action
#     describe 'GET #new' do
#       before do
#         get :new
#       end
#       it 'should return 200:OK' do
#         expect(response).to have_http_status(:success)
#       end
#       it 'renders new template' do
#         is_expected.to render_template(:new)
#       end
#       it 'renders application layout' do
#         is_expected.to render_template(:application)
#       end
#     end
#     # edit action
#     describe 'GET #edit' do
#       before do
#         patch :update, params: { id: user_post.id, post: { caption: user_post.caption,images:user_post.images} }
#       end
#       context 'when post id and Data is valid' do
#         it 'is expected to set post instance variable' do
#            expect(assigns[:post]).to eq(Post.find_by(id: user_post.id))
#         end
#         it 'is expected post params title and post title matches' do
#           expect(assigns[:post].caption).to eq(params[:post][:caption])
#         end
#       end
#     end
#     # delete action
#     describe 'DELETE #destroy' do
#       before do
#         delete :destroy, params: { id: user_post.id }
#       end
#       context 'when post id and Data is valid' do
#         it 'Destroy action response' do
#         byebug
#            delete :destroy, params: { id: user_post.id}
#           expect(Post.find_by(id: user_post.id)).to be_nil
#       end
#       it 'Destroy action response' do
#           delete :destroy, params: { id: 3242342 }
#           expect(Post.find_by(id: user_post.id)).to_not be_nil
#       end
#       end
#     end
#   end
# end
