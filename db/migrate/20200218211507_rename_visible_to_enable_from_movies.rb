class RenameVisibleToEnableFromMovies < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :visible, :enable
  end
end
