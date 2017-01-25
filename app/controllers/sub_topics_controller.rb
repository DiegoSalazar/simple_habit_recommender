class SubTopicsController < ApplicationController
  def index
    @sub_topics = SubTopic.all.page(params[:page]).per 20
  end

  def show
    @sub_topic = SubTopic.find params[:id]
  end
end
