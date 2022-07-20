# frozen_string_literal: true

# class of items that the admin will create
class Item < ApplicationRecord
  scope :permited_items, -> { where(status: 'permit') }
  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items, dependent: :destroy
  has_one_attached :image
  validates :status, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { only_float: true, greater_than: 0 }
  validate :save_object?
  validate :image_type

  enum status: { permit: 0, not_permit: 1 }
  # setting the default status at the time of creation
  after_initialize :set_default_status, if: :new_record?
  def set_default_status
    self.status ||= :permit
  end

  def thumbnail
    image.variant(resize: '100x100!').processed
  end

  private

  def save_object?
    if Category.all.count.zero?
      errors.add(:category, 'should be created first') if Category.all.count.zero?
    elsif category_ids.count.zero?
      errors.add(:category, 'is not selected')
    end
  end

  def image_type
    errors.add(:image, 'is missing') if (image.attached?) == false
  end
end
