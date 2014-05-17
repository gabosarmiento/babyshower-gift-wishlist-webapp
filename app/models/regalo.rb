# == Schema Information
#
# Table name: regalos
#
#  id         :integer          not null, primary key
#  titulo     :string(255)
#  imagen     :string(255)
#  state      :string(255)
#  url        :string(255)
#  lista_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Regalo < ActiveRecord::Base
  belongs_to :lista
  mount_uploader :imagen, ImagenUploader
   validates :titulo, length: { minimum: 5 }, presence: true
   validates :imagen, presence: true 
   validates :url, :format => URI::regexp(%w(http https))
   
   #state machine
   state_machine initial: :disponible do
     event :reservar do
        transition :disponible => :reservado
     end

     event :liberar do 
        transition :reservado => :disponible
     end

     event :comprar do
        transition :reservado => :comprado
     end
   end
end
