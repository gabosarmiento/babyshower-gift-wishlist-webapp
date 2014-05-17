class CreateCompromisos < ActiveRecord::Migration
  def change
    create_table :compromisos do |t|
      t.references :user, index: true
      t.references :regalo, index: true
      t.string :value

      t.timestamps
    end
  end
end
