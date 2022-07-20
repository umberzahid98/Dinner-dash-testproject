# frozen_string_literal: true

# inline item policy
class InlineItemPolicy < ApplicationPolicy
  def update?
    user?
  end

  def create?
    user?
  end

  def destroy?
    user?
  end
end
