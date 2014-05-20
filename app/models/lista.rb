# == Schema Information
#
# Table name: listas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Lista < ActiveRecord::Base
  has_many :regalos
  belongs_to :user
  validates :nombre, length: { minimum: 5 }, presence: true
end
