# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def update?
    admin?
  end
end
