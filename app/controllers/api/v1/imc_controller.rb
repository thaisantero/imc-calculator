module Api
  module V1
    class ImcController < ActionController::API
      def create
        classification = imc_classification
        render status: :ok, json:
        {
          imc: imc_calculator,
          classification: classification[:classification],
          obesity: classification[:obesity]
        }
      end

      private

      def imc_classification
        if imc_calculator < 18.5
          { classification: 'Magreza', obesity: '0' }
        elsif imc_calculator < 24.9
          { classification: 'Normal', obesity: '0' }
        elsif imc_calculator < 29.9
          { classification: 'Sobrepeso', obesity: 'I' }
        elsif imc_calculator < 39.9
          { classification: 'Obesidade', obesity: 'II' }
        else
          { classification: 'Obesidade Grave', obesity: 'III' }
        end
      end

      def imc_calculator
        (imc_params[:weight] / (imc_params[:height]**2)).round(1)
      end

      def imc_params
        params.permit(:height, :weight)
      end
    end
  end
end
