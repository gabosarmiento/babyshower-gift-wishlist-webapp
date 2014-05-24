# == Schema Information
#
# Table name: regalos
#
#  id                 :integer          not null, primary key
#  titulo             :string(255)
#  imagen             :string(255)
#  url                :string(255)
#  lista_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  donde_lo_consigues :text
#  position           :integer
#  descripcion        :text
#

class Regalo < ActiveRecord::Base
  belongs_to :lista
  has_one :compromiso, dependent: :destroy
  acts_as_list scope: :lista
  mount_uploader :imagen, ImagenUploader
  validates :titulo, length: { minimum: 5 }, presence: true
  validates :imagen, presence: true 
  validates :donde_lo_consigues, :allow_blank => true, length: { maximum: 300 }
  validates :url, :allow_blank => true, :format => URI::regexp(%w(http https))
  validates :descripcion, :allow_blank => true, presence: true
end
