class ListensController < ApplicationController
  def index
    @listens = Listen.recent.page params[:page]
  end
end
