# frozen_string_literal: true

# User class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders, dependent: :destroy
  has_many :inline_items, dependent: :destroy
  validates :display_name, length: { minimum: 2, maximum: 32, allow_blank: true }
  validates :full_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :user
  end
end
