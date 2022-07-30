# frozen_string_literal: true

# orders controller
class OrdersController < ApplicationController
  # include FindingInlineItem
  before_action :set_order, only: %i[show update]
  before_action :authorize_order, only: %i[index update create]

  def index
    fetching_orders
    return unless params[:search]
    @orders = Order.where(status: params[:search])
    @status_searched = params[:search]
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def update
    @orders = Order.all.order(:created_at)
    respond_to do |format|
      if @order.update(order_params)
        flash.now[:notice] = "Order is updated successfully"
        format.js
      else
        flash.now[:notice] = "Order is not updated"
        format.js
      end
    end
  end

  def new
    @order = Order.new
  end

  def create
    if (!user_inline_item_id.empty?)
      @order = current_user.orders.new(inline_item_ids: user_inline_item_id, price: calculate_bill)
      @user_cart = current_user.inline_items.where(status: "non-checkedout").update_all(status: "checkedout")
      if @order.save
        redirect_to order_url(@order), notice: "order was successfully created."
      end
    else
      no_inline_item
    end
    respond_to do |format|
      format.js
    end

  end

  private

  def authorize_order
    authorize Order
  end

  def fetching_orders
    @orders = if current_user.admin?
        Order.all.order(:created_at)
      else
        Order.user_orders(current_user.id)
      end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :status, :price)
  end

  def calculate_bill
    user_inline_item.sum("price*quantity")
  end

  def user_inline_item
    find_user_inline_items
  end

  def user_inline_item_id
    find_user_inline_items.pluck(:id)
  end

  def find_user_inline_items
    if current_user
      InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")
    end
  end

  def no_inline_item
    @empty_cart = true
    respond_to do |format|
      format.js { flash.now[:notice] = "No inline Item present" }
    end
  end
end
