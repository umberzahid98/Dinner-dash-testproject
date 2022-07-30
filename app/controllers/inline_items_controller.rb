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
        @user_inline_items = user_inline_item
        format.js { flash.now[:notice] = "Cart Item not updated" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @inline_item
        @inline_item.destroy
        @user_inline_items = user_inline_item
        format.js { flash.now[:notice] = "Inline Item removed from cart!" }
      else
        @user_inline_items = user_inline_item
        format.js { flash.now[:notice] = "Inline Item not removed from cart!" }
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
    @inline_item = InlineItem.find_by(id: params[:id])
  end

  def authorize_inline_item
    authorize InlineItem if current_user
  end

  def set_cart

    if(params[:inline_item][:cart_id])
      @cart = Cart.find(params[:inline_item][:cart_id])
    else
      @cart = Cart.find_by(id: session[:cart_id])
    end
  end

  def user_inline_item
    if current_user
      InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")
    else
      if(params[:inline_item][:cart_id])
        cart = Cart.find_by(id: params[:inline_item][:cart_id])
        InlineItem.where(cart: params[:inline_item][:cart_id]) if cart
      else
        cart = Cart.find_by(id: session[:cart_id])
        InlineItem.where(cart: session[:cart_id]) if cart
      end
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
