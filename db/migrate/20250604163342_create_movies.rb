class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :category
      t.string :description
      t.string :year
      t.string :image

      t.timestamps
    end
    add_index :movies, :title
    add_index :movies, :category
  end
end
