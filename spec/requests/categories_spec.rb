# require 'rails_helper'
# require_relative '../support/devise'
# RSpec.describe CategoriesController, type: :controller do
#   describe "GET /" do
#     let!(:new_categories) { FactoryBot.create_list(:category,5) }
#     let!(:new_admin) { FactoryBot.create(:admin) }
#     let!(:params) { {category: {name: new_category.name}}}
#     let!(:new_category) { FactoryBot.create(:category) }

#   describe "POST #create" do
#     before do
#       post :create, params: params, format: "js"
#     end
#     context "creates a category" do
#       it "create category" do
#         expect(assigns[:category]).to be_instance_of(Category)
#       end
#       it "is expected to have name of the new created category" do
#         expect(assigns[:category].name).to eq(new_category.name )
#       end
#       it 'is expected add the new add created to database' do
#         expect(Category.last).to eq(new_category)
#       end
#       it 'check post has been added to database' do
#           expect(Category.all.size).to eq(1)
#       end
#       it 'is expected to return javascript file' do
#         assert(response.content_type, "text/javascript")
#       end
#       it "works" do
#         expect(response).to have_http_status(200)
#       end

#     end
#   end

#   describe "GET #index" do
#     before do
#       get :index
#     end
#     context "index for category" do
#     it 'renders index template' do
#       is_expected.to render_template(:index)
#     end

#     it 'renders application layout' do
#       is_expected.to render_template(:application)
#     end
#     end
#   end

# end
# end
