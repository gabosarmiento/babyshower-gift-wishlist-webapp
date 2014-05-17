class CreateRegalos < ActiveRecord::Migration
  def change
    create_table :regalos do |t|
      t.string :titulo
      t.string :imagen
      t.string :url
      t.references :lista, index: true

      t.timestamps
    end
  end
end
