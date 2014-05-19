# == Schema Information
#
# Table name: convidados
#
#  id           :integer          not null, primary key
#  email        :string(255)
#  anfitrion_id :integer
#  invitado_id  :integer
#  token        :string(255)
#  fiesta_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Convidado < ActiveRecord::Base

  before_create :generate_token
  before_save :check_user_existence

  belongs_to :fiesta
  belongs_to :anfitrion, :class_name => 'User'
  belongs_to :invitado, :class_name => 'User'
  
  def generate_token
   self.token = Digest::SHA1.hexdigest([self.fiesta_id, Time.now, rand].join)
  end

  def check_user_existence
    invitado = User.find_by_email(email)
   if invitado
      self.invitado_id = invitado.id
   end
 end

end
