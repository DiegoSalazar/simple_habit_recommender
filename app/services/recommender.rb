class Recommender
  def initialize(sub_topic, per = 4, page = 0)
    @sub_topic, @per, @page = sub_topic, per, page
  end

  def ask
    sub_topics = if get_recommendation
      get_recommendation.recommended_subtopic_ids
    else
      get_sub_topics.tap do |sub_topics|
        Recommendation.create({
          subtopic_id: @sub_topic.subtopic_id,
          recommended_subtopic_ids: sub_topics.map { |s, l| [s, l.size] }
        })
      end
    end

    Kaminari.paginate_array(sub_topics).page(@page).per @per
  end

  def get_recommendation
    @recommendation ||= Recommendation.find_by_subtopic_id @sub_topic.subtopic_id
  end

  def get_sub_topics
    sub_topics = {}
    
    users_also_listened.each do |user|
      user.listens.each do |listen|
        next if listen.subtopic_id == @sub_topic.subtopic_id
        sub_topics[listen.subtopic_id] ||= []
        sub_topics[listen.subtopic_id] << listen
      end
    end
    sub_topics.sort_by { |_, listens| listens.size }.reverse
  end

  def users_also_listened
    User.who_listened_to(@sub_topic.subtopic_id)
  end
end
