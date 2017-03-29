class Api::V1::EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_project

  def create
    if @project
      e = @project.events.create!(event_params)
      e.update(variables: event_params[:variables])
    end

    head :ok
  end


  private

    def set_project
      @project = Project.find_by(client_id: params[:client_id])
    end

    def event_params
      params.require(:event).permit(:client_id, :event_type).tap do |whitelisted|
        whitelisted[:variables] = params[:event][:variables]
      end
    end

end
