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

require 'test_helper'

class SubTopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
