# frozen_string_literal: true

module Api
  module V1
    class ReadingsController < ApplicationController
      @@events ||= {}

      def create # rubocop:disable Metrics/AbcSize
        input = Api::V1::ReadingForm.new(reading_params)

        return render json: { errors: input.errors }, status: :unprocessable_entity if input.invalid?

        device_id = reading_params[:id]
        readings = reading_params[:readings]

        @@events[device_id] ||= Set.new

        readings.each do |reading|
          @@events[device_id] << reading
        end

        persist_events
        render status: :created
      end

      def latest_timestamp
        return render json: { errors: 'Device id not found' }, status: :not_found if @@events[id_param].nil?

        latest_timestamp = @@events[id_param].max_by { |reading| reading['timestamp'] }['timestamp']

        render json: { latest_timestamp: latest_timestamp }
      end

      def cumulative_count
        return render json: { errors: 'Device id not found' }, status: :not_found if @@events[id_param].nil?

        cumulative_count = @@events[id_param].sum { |reading| reading['count'] }

        render json: { cumulative_count: cumulative_count }
      end

      def self.events
        @@events
      end

      def self.events=(value)
        @@events = value
      end

      private

      def persist_events
        Rails.root.join("config/#{Rails.env}_data.json").write(@@events.to_json)
      end

      def reading_params
        params.require(:reading).permit(:id, readings: %i[timestamp count])
      end

      def id_param
        params.require(:id)
      end
    end
  end
end
