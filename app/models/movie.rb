class Movie < ApplicationRecord
  validates :name, presence: true
  validates :visible, inclusion: { in: [true, false] }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 255 }
end
