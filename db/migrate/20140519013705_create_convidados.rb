class CreateConvidados < ActiveRecord::Migration
  def change
    create_table :convidados do |t|
      t.string :email
      t.integer :anfitrion_id
      t.integer :invitado_id
      t.string :token
      t.references :fiesta, index: true

      t.timestamps
    end
  end
end
