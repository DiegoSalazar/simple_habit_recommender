class RecommendationsController < ApplicationController
  def index
    if params[:subtopic].to_s.strip.blank?
      flash[:alert] = "Please provide a subtopic parameter: '/recommendations?subtopic=X' or paste the subtopic into the search field above."
      redirect_to root_path and return
    end

    per = params.fetch :per, 4
    page = params[:page]
    results = Recommender.new(params[:subtopic]).solve
    @recommendations = Kaminari.paginate_array(results).page(page).per per

    respond_to do |format|
      format.html do
        @sub_topic = SubTopic.find_by_subtopic_id params[:subtopic]
      end

      format.json do
        subtopic_ids = @recommendations.map &:first
        render json: subtopic_ids
      end
    end
  end
end
