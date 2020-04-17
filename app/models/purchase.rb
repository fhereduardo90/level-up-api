class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :quantity, numericality: { greater_than: 0, only_integer: true }
  validates :price, numericality: { greater_than: 0 }
end
