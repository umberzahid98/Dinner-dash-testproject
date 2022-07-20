# frozen_string_literal: true

# category policy
class CategoryPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def index?
    admin?
  end
end
