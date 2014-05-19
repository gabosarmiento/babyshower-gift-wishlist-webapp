# == Schema Information
#
# Table name: compromisos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  regalo_id  :integer
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Compromiso < ActiveRecord::Base
  belongs_to :user
  belongs_to :regalo
end
