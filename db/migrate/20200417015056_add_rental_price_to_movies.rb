class AddRentalPriceToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :rental_price, :decimal, precision: 8, scale: 2, null: false, default: 0
  end
end
