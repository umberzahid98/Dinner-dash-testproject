# frozen_string_literal: true

# order policy
class OrderPolicy < ApplicationPolicy
  def index?
    admin? || user?
  end

  def create?
    user?
  end

  def update?
    admin?
  end
end
