class CreateListas < ActiveRecord::Migration
  def change
    create_table :listas do |t|
      t.string :nombre
      t.references :user, index: true

      t.timestamps
    end
  end
end
