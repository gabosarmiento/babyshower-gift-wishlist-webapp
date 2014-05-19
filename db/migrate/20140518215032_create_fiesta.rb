class CreateFiesta < ActiveRecord::Migration
  def change
    create_table :fiesta do |t|
      t.string :nombre
      t.boolean :public,  default: false
      t.text :descripcion
      t.references :user, index: true

      t.timestamps
    end
  end
end
