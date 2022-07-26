require 'rails_helper'
# require_relative '../support/devise'
RSpec.describe InlineItemsController, type: :request do
  describe "GET /" do
    let!(:user) {FactoryBot.create(:user)}
    let!(:item) { FactoryBot.create(:item) }
    let!(:cart) {Cart.create }
    let!(:params) { { inline_item: { price: item.price, quantity: 1, item_id: item.id, user_id: user.id, cart_id:cart.id }}}
    let!(:user_inline_item) {FactoryBot.create(:user_inline_item, cart:cart.id, user_id: user.id, item_id: item.id )}

    # create action
    before do
      sign_in user
    end

    describe "create" do
      before do
        post inline_items_url, params: params, xhr: true
      end
      context "when correct attributes are given" do
        it 'is expected to create new inline item successfully' do
          expect(assigns[:inline_item]).to be_instance_of(InlineItem)
          expect(response).to be_successful
          assert(response.content_type, "text/javascript")
          expect(assigns[:inline_item].user_id).to eq(user.id)
          expect(assigns[:inline_item].quantity).to eq(params[:inline_item][:quantity])
          expect(assigns[:inline_item].price).to eq(params[:inline_item][:price])
          expect(assigns[:inline_item].item).to eq(item)
          expect(flash[:notice]).to eq("added to cart!")
        end
      end
      context "when correct attributes are not given" do
        let!(:params) { { inline_item: { price: "item price", quantity: "string", item_id: item.id, user_id: user.id, cart_id:cart.id}}}
        it 'is not expected to create new inline item' do
          expect(response).to be_successful
          assert(response.content_type, "text/javascript")
          expect(assigns[:inline_item].price).to_not eq("item price")
          expect(assigns[:inline_item].quantity).to_not eq("string")
          expect(flash[:notice]).to eq("Not added to cart!")
        end
      end
    end

    # update action
    describe "update" do
      context "with valid attributes" do
        before do
          patch inline_item_url(user_inline_item.id), params: { inline_item: { price: 90, quantity:9}}, xhr: true
        end
        it "is expected to update the inline items" do
          expect(assigns[:inline_item].price).to eq(90)
          expect(assigns[:inline_item].quantity).to eq(9)
          expect(assigns[:inline_item].user_id).to eq(user.id)
          expect(assigns[:inline_item]).to be_instance_of(InlineItem)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Cart Item updated")
        end
      end
      context "with invalid attributes" do
        before do
          patch inline_item_url(user_inline_item.id), params: { inline_item: { price: "xcvxcv", quantity: "amber"}}, xhr: true
        end
        it "is not expected to update the inline items" do
          expect(assigns[:inline_item].price).to_not eq("xcvxcv")
          expect(assigns[:inline_item].quantity).to_not eq("amber")
          expect(assigns[:inline_item].user_id).to eq(user.id)
          expect(assigns[:inline_item]).to be_instance_of(InlineItem)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Cart Item not updated")
        end
      end
    end

    # describe delete
    describe 'inline_item #delete' do
      context "with destroy action" do
        it 'successful Destroy action response' do
          delete inline_item_url(user_inline_item), xhr:true
          expect(InlineItem.find_by(id: user_inline_item.id)).to be_nil
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Inline Item removed from cart!")
        end
        it 'unsuccessful Destroy action response' do
          delete inline_item_url(345345), xhr:true
          expect(InlineItem.find_by(id: user_inline_item.id)).to_not be_nil
          expect(response).to be_successful
          expect(assigns[:inline_item]).to be(nil)
          expect(flash[:notice]).to eq("Inline Item not removed from cart!")
        end
      end
    end

    describe "offline user" do
      before do
        sign_out user
      end
      context "with valid attributes " do
        let!(:params) { { inline_item: { price: item.price, quantity: 1, item_id: item.id, user_id: nil, cart_id:cart.id }}}

        it 'is expected to create new inline item successfully without current user' do
          post inline_items_url, params: params, xhr: true
          expect(assigns[:inline_item]).to be_instance_of(InlineItem)
          expect(response).to be_successful
          assert(response.content_type, "text/javascript")
          expect(assigns[:inline_item].user_id).to eq(nil)
          expect(assigns[:inline_item].quantity).to eq(params[:inline_item][:quantity])
          expect(assigns[:inline_item].price).to eq(params[:inline_item][:price])
          expect(assigns[:inline_item].item).to eq(item)
          expect(flash[:notice]).to eq("added to cart!")
        end
      end
    end

    describe "offline user" do
      before do
        sign_out user
      end
      context "with valid attribues" do

        it "is expected to update new inline item successfully without current user" do
          patch inline_item_url(user_inline_item.id), params: { inline_item: { price: 90, quantity:9,cart_id: cart.id}}, xhr: true
          expect(assigns[:inline_item].price).to eq(90)
          expect(assigns[:inline_item].quantity).to eq(9)
          expect(assigns[:inline_item].user_id).to_not eq(nil)
          expect(assigns[:inline_item]).to be_instance_of(InlineItem)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Cart Item updated")
        end
      end
    end
  end
end
