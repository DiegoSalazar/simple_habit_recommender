# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :listens, primary_key: :user_id
  validates :user_id, uniqueness: true

  scope :who_listened_to, -> subtopic_id { 
    joins("RIGHT JOIN listens ON listens.user_id = users.user_id").
    where listens: { subtopic_id: subtopic_id }
  }
end

<<-SQL
SELECT subtopic_id, COUNT(id) AS listens_count FROM listens
WHERE listens.user_id IN (
  SELECT users.user_id FROM users
  RIGHT JOIN listens ON listens.user_id = users.user_id
  WHERE listens.subtopic_id = '575f6209a06acf0300140150'
)
GROUP BY subtopic_id
ORDER BY listens_count DESC
SQL