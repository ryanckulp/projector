class Api:V1:EventsController < ApplicationController

  def create

  end


  private

    def event_params
      params.require(:event).permit(:event_type, )
    end

end
