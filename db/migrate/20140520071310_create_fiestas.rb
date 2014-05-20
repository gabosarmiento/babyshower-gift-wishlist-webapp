class CreateFiestas < ActiveRecord::Migration
  def change
    create_table :fiestas do |t|
      t.string :nombre
      t.text :descripcion
      t.string :fecha_y_hora_inicio
      t.string :fecha_y_hora_cierre
      t.string :lugar

      t.timestamps
    end
  end
end
