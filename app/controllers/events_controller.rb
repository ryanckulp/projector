class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:configure]
  before_action :set_event, only: [:destroy]

  def destroy
  end

  def configure
  end


  private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def set_event
      @event = current_user.events.find(params[:id])
    end

end
