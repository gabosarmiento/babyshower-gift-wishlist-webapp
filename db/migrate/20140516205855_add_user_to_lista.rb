class AddUserToLista < ActiveRecord::Migration
  def change
    add_column :lista, :user_id, :integer
    add_index :lista, :user_id
  end
end
