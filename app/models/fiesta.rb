# == Schema Information
#
# Table name: fiesta
#
#  id          :integer          not null, primary key
#  nombre      :string(255)
#  public      :boolean          default(FALSE)
#  descripcion :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Fiesta < ActiveRecord::Base
  belongs_to :user
  has_many :rsvps
  has_many :users, through: :rsvps
  has_many :convidados
end
