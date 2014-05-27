# == Schema Information
#
# Table name: listas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  fiesta_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class Lista < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nombre, use: [:slugged, :history]
  belongs_to :fiesta
  has_many :regalos, dependent: :destroy
  
  validates :nombre, length: { minimum: 5 }, presence: true
   def should_generate_new_friendly_id?
   nombre_changed?
  end
end
