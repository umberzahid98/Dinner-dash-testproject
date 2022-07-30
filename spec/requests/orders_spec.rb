require 'rails_helper'
# require_relative '../support/devise'
RSpec.describe OrdersController, type: :request do
  describe "GET /" do

    # login_user(user)
    let!(:user) {FactoryBot.create(:user)}
    let!(:admin) {FactoryBot.create(:admin)}

    let!(:inline_item1) {FactoryBot.create(:user_inline_item,user_id: user.id)}
    let!(:inline_item2) {FactoryBot.create(:user_inline_item,user_id: user.id)}
    let!(:user_order) { FactoryBot.create(:order, user_id: user.id,price: ((inline_item1.quantity*inline_item1.price)+(inline_item2.quantity*inline_item2.price)),inline_item_ids: [inline_item1.id,inline_item2.id])}
  # let!(:user_two) {FactoryBot.create(:user)}

    # create action

    before do
      sign_in user
    end

    describe "create" do
      before do
        post orders_url, xhr: true
      end
      
      context "" do
        it 'is expected to create new order  successfully' do
          expect(assigns[:order]).to be_instance_of(Order)
          expect(response).to be_successful
          assert(response.content_type, "text/javascript")
          expect(assigns[:order].user_id).to eq(user.id)
          expect(assigns[:order].status).to eq("ordered")
          expect(assigns[:order].inline_item_ids[0]).to eq(inline_item1.id)
          expect(assigns[:order].inline_item_ids[1]).to eq(inline_item2.id)
          expect(assigns[:order].price).to eq(user_order.price)
          expect(flash[:notice]).to eq("order was successfully created.")
        end
      end
    end

    describe "index " do
      context "with valid attributes" do
        it "is expected to return the orders" do
          get orders_url(search:"ordered"), xhr: true
          expect(assigns[:status_searched]).to eq("ordered")
          expect(assigns[:orders][0]).to be_instance_of(Order)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
        end
      end

      context "with invalid attributes" do
        it "is not expected to return the orders" do
          get orders_url(search:"paid"), xhr: true
          expect(assigns[:status_searched]).to_not eq("ordered")
          expect(assigns[:orders].length).to eq(0)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
        end
      end
    end

    describe "index with admin " do
      before do
        sign_in admin
      end
      context "with valid attributes" do
        it "is expected to return the orders" do
          get orders_url(search:"ordered"), xhr: true
          expect(assigns[:status_searched]).to eq("ordered")
          expect(assigns[:orders][0]).to be_instance_of(Order)
          expect(assigns[:orders].length).to be(1)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
        end
      end
    end

    describe "order new" do
      context "new order action" do
        it "is not expected to return the orders" do
          get new_order_url, xhr: true
          expect(assigns[:order]).to be_instance_of(Order)
          expect(response).to be_successful
        end
      end
    end

    # update action
    describe "update" do
      context "with valid attributes" do
        before do
          patch order_url(user_order.id), params: { order: { status: "paid"}}, xhr: true
        end
        it "is expected to update the order" do
          expect(assigns[:order].status).to eq("paid")
          expect(assigns[:order]).to be_instance_of(Order)
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Order is updated successfully")
        end
      end
      context "with invalid attributes" do
        before do
          patch order_url(user_order.id), params: { order: { price: "xcvxcv"}}, xhr: true
        end
        it "is not expected to update the order" do
          assert(response.content_type, "text/javascript")
          expect(response).to be_successful
          expect(flash[:notice]).to eq("Order is not updated")
        end
      end
    end
  end
end
