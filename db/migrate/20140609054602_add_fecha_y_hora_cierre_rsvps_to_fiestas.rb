class AddFechaYHoraCierreRsvpsToFiestas < ActiveRecord::Migration
  def change
    add_column :fiestas, :fecha_y_hora_cierre_rsvps, :string
  end
end
