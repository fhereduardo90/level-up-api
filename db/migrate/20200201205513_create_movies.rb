class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.string :description, limit: 255
      t.integer :stock, null: false, default: 0
      t.boolean :visible, null: false, default: true

      t.timestamps
    end

    add_index :movies, :name, unique: true
  end
end
