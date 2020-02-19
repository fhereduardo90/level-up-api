class Movie < ApplicationRecord
  has_many :purchases

  validates :name, presence: true, uniqueness: true
  validates :enable, inclusion: { in: [true, false] }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 255 }
end
