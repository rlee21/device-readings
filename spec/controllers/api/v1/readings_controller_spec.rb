# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReadingsController do
  # before do
  #   readings = {
  #     '36d5658a-6908-479e-887e-a949ec199272' => [
  #       { timestamp: '2021-09-29T16:08:15+01:00', count: 2 },
  #       { timestamp: '2021-09-29T16:09:15+01:00', count: 15 }
  #     ]
  #   }
  #   Api::V1::ReadingsController.events(readings)
  # end

  describe '#create' do
    before do
      post :create, params: {
        id: '36d5658a-6908-479e-887e-a949ec199272',
        readings: [
          { timestamp: '2021-09-29T16:08:15+01:00', count: 2 },
          { timestamp: '2021-09-29T16:09:15+01:00', count: 15 }
        ]
      }
    end

    it 'stores readings for a given device' do
      expect(response).to have_http_status(:created)
    end
  end

  # describe '#latest_timestamp' do

  #   it 'returns the latest timestamp for a id' do
  #     get :latest_timestamp, params: { id: '12345' }

  #     expect(response).to have_http_status(:success)
  #     expect(response).to have_http_status(200)
  #     expect(response.parsed_body).to eq({"id"=>"12345", "latest_timestamp"=>"2024-01-30 19:22:26"})
  #   end
  # end

  # describe '#cumulative_count' do
  #   it 'returns the cumulative count for a id' do
  #     get :cumulative_count, params: { id: '12345' }

  #     expect(response).to have_http_status(:success)
  #     expect(response).to have_http_status(200)
  #     expect(response.parsed_body).to eq({"id"=>"12345", "cumulative_count"=>4})
  #   end
  # end
end
