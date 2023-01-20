require 'rails_helper'

describe Api::V1::ImcController, type: :request do
  describe 'POST#create api/v1/imc' do
    context 'when token JWT is not valid' do
      it 'returns 401 status and JSON with error' do
        params = {
          height: 1.70,
          weight: 76
        }

        post '/api/v1/imc', params:, headers: { 'Authorization': 'Bearer not_valid_token' }, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :unauthorized
        expect(response_parsed[:errors]).to include 'Token inválido'
      end
    end

    context 'when token JWT is not present' do
      it 'returns 401 status and JSON with error' do
        params = {
          height: 1.70,
          weight: 76
        }

        post '/api/v1/imc', params:, as: :json

        response_parsed = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status :unauthorized
        expect(response_parsed[:errors]).to include 'Token inválido'
      end
    end

    context 'when token JWT is valid' do
      context 'when height and weight sent' do
        it 'returns 200 status and imc value with classification' do
          params = {
            height: 1.70,
            weight: 76
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

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

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Altura não pode ficar em branco'
        end
      end

      context 'when weight not present' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 1.8
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Peso não pode ficar em branco'
        end
      end

      context 'when height is zero' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 0,
            weight: 76
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Altura deve ser maior que 0'
        end
      end

      context 'when weight is zero' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 1.8,
            weight: 0
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Peso deve ser maior que 0'
        end
      end

      context 'when height is negative' do
        it 'returns 400 and error in JSON' do
          params = {
            height: -1.8,
            weight: 80
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Altura deve ser maior que 0'
        end
      end

      context 'when height is negative' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 1.8,
            weight: -80
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Peso deve ser maior que 0'
        end
      end

      context 'when height is a text' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 'abc',
            weight: 80
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Altura deve ser um número'
        end
      end

      context 'when height is a text' do
        it 'returns 400 and error in JSON' do
          params = {
            height: 1.8,
            weight: 'abc'
          }

          post '/api/v1/imc', params: params, headers: { 'Authorization': 'Bearer valid_token' }, as: :json

          response_parsed = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status :bad_request
          expect(response_parsed[:errors]).to include 'Peso deve ser um número'
        end
      end
    end
  end
end
