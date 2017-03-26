class EventsController
  before_action :authenticate_user!
  before_action :set_event, only: [:destroy]

  def destroy
  end


  private

    def set_event
      @event = current_user.events.find(params[:id])
    end

end
