class CreateLista < ActiveRecord::Migration
  def change
    create_table :lista do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
