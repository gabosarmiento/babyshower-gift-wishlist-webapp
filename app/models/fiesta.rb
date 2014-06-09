# == Schema Information
#
# Table name: fiestas
#
#  id                        :integer          not null, primary key
#  nombre                    :string(255)
#  descripcion               :text
#  fecha_y_hora_inicio       :string(255)
#  fecha_y_hora_cierre       :string(255)
#  lugar                     :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  email_contacto            :string(255)
#  telefono_contacto         :string(255)
#  slug                      :string(255)
#  fecha_y_hora_cierre_rsvps :string(255)
#

class Fiesta < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nombre, use: [:slugged, :history]

  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps, source: :anfitrion
  has_many :listas, dependent: :destroy
  has_many :convidados, dependent: :destroy
  
  validates :nombre, length: { minimum: 5 }, presence: true
  validates :descripcion, length: { minimum: 10 }, presence: true
  validates :lugar, length: {minimum: 5}, presence: true
  validates :fecha_y_hora_inicio, presence: true
  validates :fecha_y_hora_cierre, presence: true
  validates :fecha_y_hora_cierre_rsvps, presence: true
  validates_format_of :fecha_y_hora_cierre, :with => /\A(0[1-9]|[12][0-9]|3[01])[\/](0[1-9]|1[012])[\/](20)\d\d(\s)(0?[1-9]|1[012])(:[0-5]\d)(\s)([AP]M)\Z/
  validates_format_of :fecha_y_hora_inicio, :with => /\A(0[1-9]|[12][0-9]|3[01])[\/](0[1-9]|1[012])[\/](20)\d\d(\s)(0?[1-9]|1[012])(:[0-5]\d)(\s)([AP]M)\Z/
  validates_format_of :fecha_y_hora_cierre_rsvps, :with => /\A(0[1-9]|[12][0-9]|3[01])[\/](0[1-9]|1[012])[\/](20)\d\d(\s)(0?[1-9]|1[012])(:[0-5]\d)(\s)([AP]M)\Z/
  validates :telefono_contacto, :allow_blank => true, presence: true
  validates :email_contacto, :allow_blank => true, presence: true

  def esta_invitado?(user)
    self.convidados.where(invitado: user).present? 
  end

  def should_generate_new_friendly_id?
   nombre_changed?
  end

  def self.alerta_de_cierre_rsvp
    @fiestas = Fiesta.all
    @fiestas.each do |fiesta|
      if (fiesta.fecha_y_hora_cierre_rsvps.to_date - 4) == Date.today && (fiesta.fecha_y_hora_cierre_rsvps.to_date - 4 > 0 )
        fiesta.convidados.sin_confirmar_asistencia.each do |convidado|
          ConvidadoMailer.delay.recordatorio_asistencia(convidado)
        end
      end
    end
  end
end
