class AddDondeLoConsiguesToRegalos < ActiveRecord::Migration
  def change
    add_column :regalos, :donde_lo_consigues, :text
  end
end
