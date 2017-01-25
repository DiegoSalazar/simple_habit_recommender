class Recommender
  def initialize(subtopic_id)
    @subtopic_id = subtopic_id
  end

  def solve
    if (r = Recommendation.find_by_subtopic_id @subtopic_id)
      r.recommended_subtopic_ids
    else
      sub_topics = get_sub_topics
      create_recommendation_for sub_topics
      sub_topics
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
    end.sort_by { |_, listens| listens.size }.reverse
  end

  def create_recommendation_for(sub_topics)
    Recommendation.create({
      subtopic_id: @subtopic_id,
      recommended_subtopic_ids: sub_topics.map { |sid, listens| [sid, listens.size] }
    })
  end
end
