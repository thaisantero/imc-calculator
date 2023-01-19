require 'rails_helper'

describe Api::V1::ImcController, type: :request do
  describe 'POST#create api/v1/imc' do
    context 'quando bem sucedido' do
      it 'retorna status 200 e valor do imc' do
        params = {
          height: 1.70,
          weight: 76
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :ok
        expect(response_parsed).to include(
          {
            imc: 26.3,
            classification: 'Sobrepeso',
            obesity: 'I'
          }
        )
      end

      it 'retorna status 200 e valor do imc' do
        params = {
          height: 2,
          weight: 80
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :ok
        expect(response_parsed).to include(
          {
            imc: 20,
            classification: 'Normal',
            obesity: '0'
          }
        )
      end
    end
  end
end
