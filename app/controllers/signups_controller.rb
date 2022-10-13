class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors
    def create 
        signup = Signup.create!(signup_params)
        activity = signup.activity
        render json: activity, status: :created
    end

    private
    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def show_record_errors(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

end
