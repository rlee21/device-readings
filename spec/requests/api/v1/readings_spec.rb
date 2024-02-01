require 'swagger_helper'

RSpec.describe 'api/v1/readings', type: :request do

  path '/api/v1/readings' do

    post 'creates a reading'  do
      tags 'Readings'
      consumes 'application/json'
      parameter name: :request_body, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :string, example: '36d5658a-6908-479e-887e-a949ec199272' },
          readings: {
            type: :array,
            items: {
              type: :object,
              properties: {
                timestamp: { type: :string, format: 'date-time', example: '2021-09-29T16:08:15+01:00' },
                count: { type: :integer, example: 2 }
              },
              required: %w[timestamp count]
            }
          }
        },
        required: %w[id readings]
      }

      response(201, 'reading created') do
        let(:request_body) do
          {
            id: '36d5658a-6908-479e-887e-a949ec199272',
            readings: [
              { timestamp: '2021-09-29T16:08:15+01:00', count: 2 },
              { timestamp: '2021-09-29T16:09:15+01:00', count: 15 }
            ]
          }
        end
        run_test!
      end

      # response '422', 'invalid request' do
      #   let(:request_body) { { readings: 'invalid' } }
      #   run_test!
      # end
    end
  end

  # path '/api/v1/readings/latest_timestamp' do

  #   get('latest_timestamp reading') do
  #     response(200, 'successful') do

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/readings/cumulative_count' do

  #   get('cumulative_count reading') do
  #     response(200, 'successful') do

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
