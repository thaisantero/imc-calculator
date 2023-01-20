require 'rails_helper'

describe Api::V1::ImcController, type: :request do
  describe 'POST#create api/v1/imc' do
    context 'when height and weight sent' do
      it 'returns 200 status and imc value with classification' do
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
    end

    context 'when height not present' do
      it 'returns 400 and error in JSON' do
        params = {
          weight: 76
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Height não pode ficar em branco'
      end
    end

    context 'when weight not present' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 1.8
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Weight não pode ficar em branco'
      end
    end

    context 'when height is zero' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 0,
          weight: 76
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Height deve ser maior que 0'
      end
    end

    context 'when weight is zero' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 1.8,
          weight: 0
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Weight deve ser maior que 0'
      end
    end

    context 'when height is negative' do
      it 'returns 400 and error in JSON' do
        params = {
          height: -1.8,
          weight: 80
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Height deve ser maior que 0'
      end
    end

    context 'when height is negative' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 1.8,
          weight: -80
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Weight deve ser maior que 0'
      end
    end

    context 'when height is a text' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 'abc',
          weight: 80
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Height deve ser um número'
      end
    end

    context 'when height is a text' do
      it 'returns 400 and error in JSON' do
        params = {
          height: 1.8,
          weight: 'abc'
        }

        post '/api/v1/imc', params: params, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :bad_request
        expect(response_parsed[:errors]).to include 'Weight deve ser um número'
      end
    end
  end
end
