class AddSlugToListas < ActiveRecord::Migration
  def change
    add_column :listas, :slug, :string
    add_index :listas, :slug
  end
end
