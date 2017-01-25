class RecommendationsController < ApplicationController
  def index
    if params[:subtopic].blank?
      flash[:alert] = "Please provide a subtopic parameter: '/recommendations?subtopic=X' or paste the subtopic into the search field above."
      redirect_to root_path and return
    end

    @sub_topic = SubTopic.find_by_subtopic_id params[:subtopic]
    @recommender = Recommender.new @sub_topic.subtopic_id, params.fetch(:per, 4), params[:page]

    respond_to do |format|
      format.html
      format.json do
        render json: { recommended_subtopics: @recommender.ask.map(&:first) }
      end
    end
  end
end
