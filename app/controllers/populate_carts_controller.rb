# frozen_string_literal: true

# homes controller
class PopulateCartsController < ApplicationController
  before_action :set_cart, only: %i[index]

  def index
    if current_user
      check_current_user
    else
      @cart = Cart.new
      if @cart.save
        session[:cart_id] = @cart.id
      end
    end
    redirect_to '/items'
  end

  private

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
  end

  def check_current_user
    return unless @cart

    if current_user.user?
      populate_cart
    elsif current_user.admin?
      ActiveRecord::Base.transaction do
        InlineItem.where(cart: session[:cart_id]).destroy_all
      end

    end
  end

  def populate_cart
    # get the ids of elements in user cart
    user_inline_items_ids = InlineItem.where(user_id: current_user.id).where(status: 'non-checkedout').pluck(:item_id)
    # get the inline elements that are present in session
    session_inline_items = InlineItem.where(cart: session[:cart_id])
    # loop through session items
    ActiveRecord::Base.transaction do
      session_inline_items.each do |session_inline_item|
        # check to filter inline items not present in cart already
        unless user_inline_items_ids.include?(session_inline_item.item_id)
          session_inline_item.update!(user_id: current_user.id)
        end
      end
    rescue StandardError
      raise ActiveRecord::Rollback
    end
  end
end
