class Recommender
  def initialize(subtopic_id)
    @subtopic_id = subtopic_id
  end

  def solve
    results = ActiveRecord::Base.connection.execute <<-SQL.strip_heredoc
      SELECT subtopic_id, COUNT(id) AS listens_count FROM listens
      WHERE listens.user_id IN (
        SELECT users.user_id FROM users
        RIGHT JOIN listens ON listens.user_id = users.user_id
        WHERE listens.subtopic_id = '#{@subtopic_id}'
      ) 
      AND listens.subtopic_id != '#{@subtopic_id}'
      GROUP BY subtopic_id
      ORDER BY listens_count DESC
    SQL
    results.to_a
  end
end
