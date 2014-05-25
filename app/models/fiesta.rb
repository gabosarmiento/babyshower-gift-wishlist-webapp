# == Schema Information
#
# Table name: fiestas
#
#  id                  :integer          not null, primary key
#  nombre              :string(255)
#  descripcion         :text
#  fecha_y_hora_inicio :string(255)
#  fecha_y_hora_cierre :string(255)
#  lugar               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  email_contacto      :string(255)
#  telefono_contacto   :string(255)
#

class Fiesta < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps, source: :anfitrion
  has_many :listas
  has_many :convidados
  
  validates :nombre, length: { minimum: 5 }, presence: true
  validates :descripcion, length: { minimum: 20 }, presence: true
  validates :lugar, length: {minimum: 10}, presence: true
  validates :fecha_y_hora_inicio, presence: true
  validates :fecha_y_hora_cierre, presence: true
  validates_format_of :fecha_y_hora_cierre, :with => /\A(0[1-9]|1[012])[\/](0[1-9]|[12][0-9]|3[01])[\/](20)\d\d(\s)(0?[1-9]|1[012])(:[0-5]\d)(\s)([AP]M)\Z/
  validates_format_of :fecha_y_hora_inicio, :with => /\A(0[1-9]|1[012])[\/](0[1-9]|[12][0-9]|3[01])[\/](20)\d\d(\s)(0?[1-9]|1[012])(:[0-5]\d)(\s)([AP]M)\Z/
  validates :telefono_contacto, :allow_blank => true, presence: true
  validates :email_contacto, :allow_blank => true, presence: true
  def esta_invitado?(user)
    unless self.convidados.empty?
      self.convidados.each do |u|
        if u.invitado_id == user.id 
          true
        end
      end
    end
  end

  def fecha
    self.fecha_y_hora_inicio
  end
end
