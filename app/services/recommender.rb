class Recommender
  def initialize(subtopic_id)
    @subtopic_id = subtopic_id
  end

  def solve
    if (r = Recommendation.find_by_subtopic_id @subtopic_id)
      r.recommended_subtopic_ids
    else
      sub_topics = get_sub_topics
      recommendation = create_recommendation_for sub_topics
      recommendation.recommended_subtopic_ids
    end
  end

  private

  def get_sub_topics
    User.who_listened_to(@subtopic_id).inject({}) do |sub_topics, user|
      user.listens.each do |listen|
        next if listen.subtopic_id == @subtopic_id
        sub_topics[listen.subtopic_id] ||= []
        sub_topics[listen.subtopic_id] << listen
      end
      sub_topics
    end.sort_by { |subtopic_id, listens| listens.size }.reverse
  end

  def create_recommendation_for(sub_topics)
    Recommendation.find_or_create_by(subtopic_id: @subtopic_id).tap do |r|
      r.recommended_subtopic_ids = sub_topics.map { |sid, listens| [sid, listens.size] }
      r.save if r.changes.any?
    end
  end
end
