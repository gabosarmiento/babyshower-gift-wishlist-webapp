# == Schema Information
#
# Table name: tiendas
#
#  id           :integer          not null, primary key
#  nombre       :string(255)
#  locacion     :string(255)
#  url          :string(255)
#  acerca_de    :text
#  pagos_online :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Tienda < ActiveRecord::Base
  has_paper_trail
  validates :nombre, length: {minimum: 4}, presence: true
  validates :locacion, :allow_blank => true, presence: true
  validates :url, :allow_blank => true, :format => URI::regexp(%w(http https))
  validates :acerca_de, :allow_blank => true, presence: true
  # validates_inclusion_of :pagos_online, in: [true, false]
end
