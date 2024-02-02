# frozen_string_literal: true

require 'swagger_helper'

module Api
  module V1
    RSpec.describe 'Device Readings API' do
      path '/api/v1/readings' do
        post 'creates reading' do
          tags 'readings'
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

          response 201, 'reading created' do
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

          response '422', 'invalid request' do
            let(:request_body) { { readings: 'invalid' } }

            run_test!
          end
        end
      end

      path '/api/v1/readings/latest_timestamp' do
        get 'fetches latest timestamp for a device' do
          tags 'readings'
          produces 'application/json'
          parameter name: :id, in: :query, type: :string, required: true, example: '36d5658a-6908-479e-887e-a949ec199272'

          response 200, 'latest timestamp found' do
            schema type: :object,
                   properties: {
                     latest_timestamp: { type: :string, format: 'date-time', example: '2021-09-29T16:08:15+01:00' }
                   },
                   required: ['latest_timestamp']

            let(:id) { '36d5658a-6908-479e-887e-a949ec199272' }

            run_test!
          end

          response 400, 'id parameter missing' do
            let(:id) { nil }

            run_test!
          end

          response 404, 'id not found' do
            let(:id) { '99999999-9999-9999-9999-999999999999' }

            run_test!
          end
        end
      end

      path '/api/v1/readings/cumulative_count' do
        get 'fetches cumulative count for a device' do
          tags 'readings'
          produces 'application/json'
          parameter name: :id, in: :query, type: :string, required: true, example: '36d5658a-6908-479e-887e-a949ec199272'

          response 200, 'cumulative count found' do
            schema type: :object,
                   properties: {
                     cumulative_count: { type: :integer, example: 17 }
                   },
                   required: ['cumulative_count']

            let(:id) { '36d5658a-6908-479e-887e-a949ec199272' }

            run_test!
          end

          response 400, 'id parameter missing' do
            let(:id) { nil }

            run_test!
          end

          response 404, 'id not found' do
            let(:id) { '99999999-9999-9999-9999-999999999999' }

            run_test!
          end
        end
      end
    end
  end
end
