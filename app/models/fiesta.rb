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
#

class Fiesta < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps, source: :anfitrion
  has_many :convidados
  validates :nombre, length: { minimum: 5 }, presence: true
  validates :descripcion, length: { minimum: 20 }, presence: true
  validates :lugar, length: {minimum: 10}, presence: true
  def esta_invitado?(user)
    unless self.convidados.empty?
      self.convidados.each do |u|
        if u.invitado_id == user.id 
          true
        end
      end
    end
  end
end
