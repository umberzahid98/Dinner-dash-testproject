# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  scope :user_orders, ->(user_id) { where(user_id: user_id) }
  belongs_to :user
  validates :status, presence: true
  enum status: { ordered: 0, paid: 1, completed: 2, cancelled: 3 }
  # setting the default status at the time of creation
  after_initialize :set_default_status, if: :new_record?
  def set_default_status
    self.status ||= :ordered
  end
end
