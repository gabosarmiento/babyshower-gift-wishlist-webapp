class CreateListas < ActiveRecord::Migration
  def change
    create_table :listas do |t|
      t.string :nombre
      t.references :fiesta, index: true

      t.timestamps
    end
  end
end
