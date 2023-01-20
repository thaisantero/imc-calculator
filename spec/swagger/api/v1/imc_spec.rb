require "swagger_helper"

RSpec.describe "/api/v1/imc_controller", type: :request do
  path "/api/v1/imc" do
    post "Calculate IMC" do
      tags "Imc"
      produces "application/json"
      consumes "application/json"
      parameter name: "Authorization", in: :header, type: :string, default: "Bearer valid_token"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          height: {
            type: :number, default: 1.70, description: "Person height"
          },
          weight: {
            type: :number, default: 70, description: "Person weight"
          }
        },
        required: ["height, weight"]
      }

      response "200", :ok do
        schema type: :object,
          properties: {
            imc: {type: :number, default: 24.22},
            obesity: {type: :string, default: "0"},
            classification: {type: :string, default: "Normal"}
          }

        run_test!
      end

      response "400", :bad_request do
        schema type: :object,
          properties: {
            errors: {type: :string, default: "mensagem de erro de validação"}
          }
        run_test!
      end

      response "401", :unauthorized do
        schema type: :object,
          properties: {
            errors: {type: :string, default: "Token inválido"}
          }
        run_test!
      end
    end
  end
end
