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
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable,  :omniauth_providers => [:facebook]
  has_many :listas
  has_many :compromisos, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :fiestas, through: :rsvps
  has_many :invitaciones, :class_name => "Convidado", :foreign_key => 'invitado_id', dependent: :destroy
  has_many :invitaciones_enviadas, :class_name => "Convidado", :foreign_key => 'anfitrion_id', dependent: :destroy
  after_create :default_role
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
                        )
      user.skip_confirmation!
      user.save
    end
    return user if user
  end
  # def self.find_for_facebook_oauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.image = auth.info.image # assuming the user model has an image
  #   end
  # end

  def role?(base_role)
  role == base_role.to_s
  end
  
  ROLES = %w[member admin]
  private
  def default_role
    self.role = 'member'
    self.save
  end
end
