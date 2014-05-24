class AddPositionToRegalo < ActiveRecord::Migration
  def change
    add_column :regalos, :position, :integer
  end
end
