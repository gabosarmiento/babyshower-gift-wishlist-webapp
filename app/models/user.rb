# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :listas
  has_many :compromisos, dependent: :destroy
  has_many :rsvps
  has_many :fiestas, through: :rsvps
  has_many :invitaciones, :class_name => "Convidado", :foreign_key => 'invitado_id'
  has_many :invitaciones_enviadas, :class_name => "Convidado", :foreign_key => 'anfitrion_id'
  after_create :default_role

  def role?(base_role)
  role == base_role.to_s
  end
  
  ROLES = %w[member admin]
  private
  def default_role
    self.role = 'member'
  end
end
