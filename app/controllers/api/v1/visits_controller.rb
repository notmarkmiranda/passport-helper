module Api
  module V1
    class VisitsController < ApiController
      before_action :require_user
      respond_to :json

      def index
        respond_with Visit.all
      end

      def create
        venue_id = YelpVenue.venue_id_for_visit(params[:venue][:yelp_id])
        up_id = params[:venue][:up_id]
        @visit = Visit.new(venue_id: venue_id, user_passport_id: up_id)
        if @visit.save
          render json:{ status: 200 }
        end
      end

      def destroy
        venue_id = YelpVenue.venue_id_for_visit(params[:venue][:yelp_id])
        up_id = params[:venue][:up_id]
        visit = Visit.get_visit(venue_id, up_id)
        visit = Visit.find_by(venue_id: venue_id, user_passport_id: up_id)
        if Visit.delete(visit)
          render json:{ status: 200 }
        end
      end

      private

    end
  end
end
