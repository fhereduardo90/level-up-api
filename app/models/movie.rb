class Movie < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :rentals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :enable, inclusion: { in: [true, false] }
  validates :stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :price, :rental_price, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 255 }
end
