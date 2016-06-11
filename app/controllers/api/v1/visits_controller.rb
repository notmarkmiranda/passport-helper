module Api
  module V1
    class VisitsController < ApiController
      respond_to :json

      def index
        respond_with Visit.all
      end
    end
  end
end
