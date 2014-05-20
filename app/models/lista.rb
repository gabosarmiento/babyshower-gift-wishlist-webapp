class Lista < ActiveRecord::Base
  belongs_to :fiesta
  has_many :regalos
  
  validates :nombre, length: { minimum: 5 }, presence: true
end
