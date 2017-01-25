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

class Listen < ActiveRecord::Base
  belongs_to :user, primary_key: "user_id"
  belongs_to :sub_topic, primary_key: :subtopic_id, foreign_key: :subtopic_id
  scope :uniq_by_user, -> { select("DISTINCT ON (listens.user_id) listens.*").order :user_id }
  scope :recent, -> { order listen_date: :desc }
  paginates_per 20

  def self.uniq_user_count
    count "DISTINCT user_id"
  end
end
