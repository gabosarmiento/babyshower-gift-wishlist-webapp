class Compromiso < ActiveRecord::Base
  belongs_to :user
  belongs_to :regalo
end
