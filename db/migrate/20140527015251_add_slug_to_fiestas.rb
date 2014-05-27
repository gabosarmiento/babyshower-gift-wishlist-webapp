class AddSlugToFiestas < ActiveRecord::Migration
  def change
    add_column :fiestas, :slug, :string
    add_index :fiestas, :slug
  end
end
