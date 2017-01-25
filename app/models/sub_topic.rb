# == Schema Information
#
# Table name: sub_topics
#
#  id          :integer          not null, primary key
#  subtopic_id :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class SubTopic < ActiveRecord::Base
  has_many :listens, primary_key: :subtopic_id, foreign_key: :subtopic_id
end
