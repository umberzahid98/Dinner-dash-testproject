# frozen_string_literal: true

# item helper
module ItemsHelper
  def present_in_cart?(item)
    if current_user
      user_inline_items = InlineItem.where(user_id: current_user.id).where(status: 'non-checkedout')
    else
      cart = Cart.find_by(id: session[:cart_id])
      user_inline_items = InlineItem.where(cart: session[:cart_id]) if cart
    end

    user_inline_items&.pluck(:item_id)&.include? item.id
  end
end
