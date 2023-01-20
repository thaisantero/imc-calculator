module Api
  module V1
    class ImcController < ApplicationController
      def create
        imc = Imc.new(height: imc_params[:height], weight: imc_params[:weight])
        if imc.valid?
          render status: :ok, json:
          {
            imc: imc.value,
            classification: imc.classification,
            obesity: imc.obesity
          }
        else
          render status: :bad_request, json: {errors: imc.errors.full_messages}
        end
      end

      private

      def imc_params
        params.permit(:height, :weight)
      end
    end
  end
end
