class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index 
        activities = Activity.all 
        render json: activities, status: :ok
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.signups.destroy
        activity.destroy
        render json: activity, status: :accepted
    end
    private 
    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
      end

end
