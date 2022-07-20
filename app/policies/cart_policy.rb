# frozen_string_literal: true

# cart policy
class CartPolicy < ApplicationPolicy
  def index?
    user?
  end
end
