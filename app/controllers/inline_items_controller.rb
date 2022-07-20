# frozen_string_literal: true

# inlineitems controller
class InlineItemsController < ApplicationController
  before_action :set_inline_item, only: %i[update destroy]
  before_action :set_cart, only: %i[create]
  before_action :initialize_item, only: %i[create]
  before_action :authorize_inline_item, only: %i[create update destroy]

  def update
    respond_to do |format|
      if @inline_item.update(inline_item_params)
        @user_inline_items = user_inline_item
        format.js { flash.now[:notice] = "Cart Item updated" }
      else
        format.js { flash.now[:notice] = "Cart Item not updated" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @inline_item.destroy
        @user_inline_items = user_inline_item
        format.js { flash.now[:notice] = "Item removed from cart!" }
      else
        format.js { flash.now[:notice] = "Item not removed from cart!" }
      end
    end
  end

  def create
    respond_to do |format|
      if @inline_item.save
        format.html { redirect_to items_path, notice: "added to cart!" }
      else
        format.html { redirect_to items_path, notice: "Not added to cart!" }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inline_item
    @inline_item = InlineItem.find(params[:id])
  end

  def authorize_inline_item
    authorize InlineItem if current_user
  end

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
  end

  def user_inline_item
    if current_user
      InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")
    else
      cart = Cart.find_by(id: session[:cart_id])
      InlineItem.where(cart: session[:cart_id]) if cart
    end
  end

  # Only allow a list of trusted parameters through.
  def inline_item_params
    params.require(:inline_item).permit(:quantity, :price, :item_id, :id)
  end

  def initialize_item
    @inline_item = if current_user
        InlineItem.new(inline_item_params.merge!(cart: @cart.id, user_id: current_user.id))
      else
        InlineItem.new(inline_item_params.merge!(cart: @cart.id))
      end
  end
end
