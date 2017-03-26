class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :set_user

	def set_user
		@user = current_user if current_user
	end

	def after_sign_in_path_for(resource)
		current_user.projects.count.zero? ? new_project_path : projects_path
	end

end
