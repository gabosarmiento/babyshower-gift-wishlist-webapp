# == Schema Information
#
# Table name: regalos
#
#  id          :integer          not null, primary key
#  titulo      :string(255)
#  imagen      :string(255)
#  estado      :string(255)
#  url         :string(255)
#  generosidad :string(255)
#  lista_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Regalo < ActiveRecord::Base
  belongs_to :lista
end
