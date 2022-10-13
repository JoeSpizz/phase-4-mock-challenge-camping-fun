class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors
    def index 
        campers = Camper.all
        render json: campers, status: :ok
    end
   def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperWithActivitiesSerializer
   end

   def create 
    camper = Camper.create!(name: params[:name], age: params[:age])
    render json: camper, status: :created
   end


   private

   def render_not_found_response
    render json: { error: "Camper not found" }, status: :not_found
  end
  def show_record_errors
    render json: {error: record.errors.full_messages}, status: :unprocessable_entity
  end
  def show_record_errors(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
