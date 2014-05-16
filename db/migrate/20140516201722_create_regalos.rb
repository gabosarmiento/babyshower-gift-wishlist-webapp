class CreateRegalos < ActiveRecord::Migration
  def change
    create_table :regalos do |t|
      t.string :titulo
      t.string :imagen
      t.string :estado
      t.string :url
      t.string :generosidad
      t.references :lista, index: true

      t.timestamps
    end
  end
end
