class AddAsistenciaToConvidado < ActiveRecord::Migration
  def change
    add_column :convidados, :asistencia, :boolean
  end
end
