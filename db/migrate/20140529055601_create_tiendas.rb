class CreateTiendas < ActiveRecord::Migration
  def change
    create_table :tiendas do |t|
      t.string :nombre
      t.string :locacion
      t.string :url
      t.text :acerca_de

      t.timestamps
    end
  end
end
