class FeedController < ApplicationController
  before_action :set_user

  def index
    @events = @user.events.where(created_at: 7.days.ago..Time.current)
  end


  private

    # TODO: update to use a UUID vs primary key id
    def set_user
      @user = User.find(params[:id])
    end

end
