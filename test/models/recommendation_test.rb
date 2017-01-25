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

require 'test_helper'

class RecommendationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
