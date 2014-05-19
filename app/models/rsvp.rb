# == Schema Information
#
# Table name: rsvps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  fiesta_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rsvp < ActiveRecord::Base
  belongs_to :anfitrion, :class_name => "User", :foreign_key => "user_id"
  belongs_to :fiesta
end
