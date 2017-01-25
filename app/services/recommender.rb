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
      user.listens.pluck(:subtopic_id).each do |subtopic_id|
        next if subtopic_id == @subtopic_id
        sub_topics[subtopic_id] ||= 0
        sub_topics[subtopic_id] += 1
      end
      sub_topics
    end.sort_by { |subtopic_id, listens_count| listens_count }.reverse
  end

  def create_recommendation_for(sub_topics)
    Recommendation.find_or_create_by(subtopic_id: @subtopic_id).tap do |r|
      r.recommended_subtopic_ids = sub_topics.map { |sid, listens_count| [sid, listens_count] }
      r.save
    end
  end
end
