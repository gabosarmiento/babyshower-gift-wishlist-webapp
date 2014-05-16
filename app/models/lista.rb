# == Schema Information
#
# Table name: lista
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Lista < ActiveRecord::Base
  has_many :regalos
  belongs_to :user
end
