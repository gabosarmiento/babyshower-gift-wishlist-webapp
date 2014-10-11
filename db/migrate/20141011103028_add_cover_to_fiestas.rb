class AddCoverToFiestas < ActiveRecord::Migration
  def change
    add_column :fiestas, :cover, :string
  end
end
