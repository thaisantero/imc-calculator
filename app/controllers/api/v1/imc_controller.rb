module Api
  module V1
    class ImcController < ActionController::API
      def create
        imc = Imc.new(height: imc_params[:height], weight: imc_params[:weight])
        render status: :ok, json:
        {
          imc: imc.value,
          classification: imc.classification,
          obesity: imc.obesity
        }
      end

      private

      def imc_params
        params.permit(:height, :weight)
      end
    end
  end
end
