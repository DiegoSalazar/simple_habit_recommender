# == Schema Information
#
# Table name: recommendations
#
#  id                       :integer          not null, primary key
#  subtopic_id              :string(255)
#  recommended_subtopic_ids :text
#  created_at               :datetime
#  updated_at               :datetime
#

class Recommendation < ActiveRecord::Base
  belongs_to :subtopic
  serialize :recommended_subtopic_ids, Array
end
