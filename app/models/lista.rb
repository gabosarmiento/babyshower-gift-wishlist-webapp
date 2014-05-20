# == Schema Information
#
# Table name: listas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  fiesta_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Lista < ActiveRecord::Base
  belongs_to :fiesta
  has_many :regalos
  
  validates :nombre, length: { minimum: 5 }, presence: true
end
