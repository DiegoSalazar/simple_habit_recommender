class Recommender
  def initialize(subtopic_id)
    @subtopic_id = subtopic_id
  end

  def solve
    if (r = Recommendation.find_by_subtopic_id @subtopic_id)
      r.recommended_subtopic_ids
    else
      s = get_sub_topics
      binding.pry # debug
      create_recommendation s
      s
    end
  end

  private

  def get_sub_topics
    binding.pry # debug
    User.who_listened_to(@subtopic_id).inject({}) do |sub_topics, user|
      user.listens.each do |listen|
        next if listen.subtopic_id == @subtopic_id
        sub_topics[listen.subtopic_id] ||= []
        sub_topics[listen.subtopic_id] << listen
      end
      binding.pry # debug
      sub_topics
    end.sort_by { |_, listens| listens.size }.reverse
  end

  def create_recommendation(sub_topics)
    Recommendation.create({
      subtopic_id: @subtopic_id,
      recommended_subtopic_ids: sub_topics.map { |sid, listens| [sid, listens.size] }
    })
  end
end
