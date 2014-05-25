class AddContactoToFiesta < ActiveRecord::Migration
  def change
    add_column :fiestas, :email_contacto, :string
    add_column :fiestas, :telefono_contacto, :string
  end
end
