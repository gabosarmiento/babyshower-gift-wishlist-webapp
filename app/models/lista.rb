class Lista < ActiveRecord::Base
  has_many :regalos
  belongs_to :user
end
