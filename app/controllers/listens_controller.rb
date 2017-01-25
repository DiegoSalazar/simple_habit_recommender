class ListensController < ApplicationController
  def index
    @listens = Listen.all.page params[:page]
  end
end
