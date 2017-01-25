# == Schema Information
#
# Table name: listens
#
#  id          :integer          not null, primary key
#  user_id     :string(255)
#  listen_date :datetime
#  subtopic_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class ListenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
