# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReadingsController do
  describe '#create' do
    context 'when params are valid' do
      let(:params) do
        {
          id: '16d5658a-6908-479e-887e-a949ec199272',
          readings: [
            { timestamp: '2021-09-29T16:08:15+01:00', count: 2 },
            { timestamp: '2021-09-29T16:09:15+01:00', count: 15 }
          ]
        }
      end

      it 'stores readings for a given device' do
        post :create, params: params, as: :json

        expect(response).to have_http_status(:created)
      end
    end

    context 'when required params are missing' do
      let(:params) { { foo: 'bar' } }
      let(:errors) do
        {
          'errors' => {
            'id' => ["can't be blank", 'id must be a string'],
            'readings' => ["can't be blank", 'readings must be an array']
          }
        }
      end

      it 'returns a client error' do
        post :create, params: params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq(errors.to_json)
      end
    end

    context 'when readings param has incorrect type' do
      let(:params) do
        {
          id: '16d5658a-6908-479e-887e-a949ec199272',
          readings: 'string'
        }
      end
      let(:errors) do
        { 'errors' => { 'readings' => ["can't be blank", 'readings must be an array'] } }
      end

      it 'returns a client error' do
        post :create, params: params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq(errors.to_json)
      end
    end
  end

  describe '#latest_timestamp' do
    context 'when device id is not found' do
      let(:errors) { { 'errors' => 'Device id not found' } }

      it 'returns the latest timestamp' do
        get :latest_timestamp, params: { id: '99999999-9999-9999-9999-999999999999' }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq(errors.to_json)
      end
    end

    context 'when timestamps are not in order' do
      let(:params) do
        {
          id: '26d5658a-6908-479e-887e-a949ec199272',
          readings: [
            { timestamp: '2024-01-31T23:04:19+01:00', count: 2 },
            { timestamp: '2024-01-31T01:01:13+01:00', count: 7 },
            { timestamp: '2024-01-31T13:08:15+01:00', count: 15 }
          ]
        }
      end

      before do
        post :create, params: params, as: :json
      end

      it 'returns the latest timestamp' do
        get :latest_timestamp, params: { id: params[:id] }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ 'latest_timestamp' => '2024-01-31T23:04:19+01:00' }.to_json)
      end
    end

    context 'when timestamps are in order' do
      let(:params) do
        {
          id: '36d5658a-6908-479e-887e-a949ec199272',
          readings: [
            { timestamp: '2024-01-31T01:01:13+01:00', count: 7 },
            { timestamp: '2024-01-31T13:08:15+01:00', count: 15 },
            { timestamp: '2024-01-31T23:04:19+01:00', count: 2 }
          ]
        }
      end

      before do
        post :create, params: params, as: :json
      end

      it 'returns the latest timestamp' do
        get :latest_timestamp, params: { id: params[:id] }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ 'latest_timestamp' => '2024-01-31T23:04:19+01:00' }.to_json)
      end
    end
  end

  describe '#cumulative_count' do
    context 'when device id is not found' do
      let(:errors) { { 'errors' => 'Device id not found' } }

      it 'returns the correct cumulative count' do
        get :cumulative_count, params: { id: '99999999-9999-9999-9999-999999999999' }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq(errors.to_json)
      end
    end

    context 'when there are duplicates' do
      let(:params) do
        {
          id: '46d5658a-6908-479e-887e-a949ec199272',
          readings: [
            { timestamp: '2024-01-31T01:01:13+01:00', count: 7 },
            { timestamp: '2024-01-31T01:01:13+01:00', count: 7 },
            { timestamp: '2024-01-31T23:04:19+01:00', count: 2 },
            { timestamp: '2024-01-31T23:04:19+01:00', count: 2 }
          ]
        }
      end

      before do
        post :create, params: params, as: :json
      end

      it 'returns the correct cumulative count' do
        get :cumulative_count, params: { id: params[:id] }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ 'cumulative_count' => 9 }.to_json)
      end
    end

    context 'when there are not duplicates' do
      let(:params) do
        {
          id: '56d5658a-6908-479e-887e-a949ec199272',
          readings: [
            { timestamp: '2024-01-31T01:01:13+01:00', count: 7 },
            { timestamp: '2024-01-31T23:04:19+01:00', count: 2 }
          ]
        }
      end

      before do
        post :create, params: params, as: :json
      end

      it 'returns the correct cumulative count' do
        get :cumulative_count, params: { id: params[:id] }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ 'cumulative_count' => 9 }.to_json)
      end
    end
  end
end
