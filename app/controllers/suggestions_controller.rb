class SuggestionsController
  before_action :authenticate_user!
  before_action :set_suggestion, only: [:destroy]

  def destroy
  end


  private

    def set_suggestion
      @suggestion = current_user.suggestions.find(params[:id])
    end

end
