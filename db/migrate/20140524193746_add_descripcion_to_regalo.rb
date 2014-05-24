class AddDescripcionToRegalo < ActiveRecord::Migration
  def change
    add_column :regalos, :descripcion, :text
  end
end
