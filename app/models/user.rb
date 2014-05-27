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
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable,  :omniauth_providers => [:facebook]
  has_many :listas
  has_many :compromisos, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :fiestas, through: :rsvps
  has_many :invitaciones, :class_name => "Convidado", :foreign_key => 'invitado_id', dependent: :destroy
  has_many :invitaciones_enviadas, :class_name => "Convidado", :foreign_key => 'anfitrion_id', dependent: :destroy
  before_create :default_role

  # Devise callback for facebook oauth 
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    data = auth.extra.raw_info
    if user
      user
    elsif user = User.where('email = ? AND provider IS NULL', data.email).first
      return false
    else
      pass = Devise.friendly_token[0,20]
      user = User.new(name: data.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: pass,
                         password_confirmation: pass
                         #avatar: auth.info.image # assuming the user model has an avatar
                        )
      user.skip_confirmation!
      user.asignar_invitaciones 
      user.save
    end
    return user if user
  end

  def asignar_invitaciones
    @invitaciones = Convidado.where(email: self.email)
    unless @invitaciones.empty?
      @invitaciones.each do |invitacion|
        self.invitaciones.push(invitacion)
      end
    end
  end

  def role?(base_role)
  role == base_role.to_s
  end
  
  ROLES = %w[member admin]
  private
  def default_role
    self.role = 'member'
    self.asignar_invitaciones
  end
 
  # protected
  # def confirmation_required?
  #   false
  # end
end
