# frozen_string_literal: true

module Api
  module V1
    class ReadingsController < ApplicationController
      @@events = {}

      def create
        input = Api::V1::DeviceForm.new(reading_params)

        return render json: input.errors, status: :unprocessable_entity if input.invalid?

        device_id = reading_params[:id]
        readings = reading_params[:readings]

        @@events[device_id] ||= Set.new

        readings.each do |reading|
          @@events[device_id] << reading
        end

        render status: :created
      end

      def latest_timestamp
        device_id = params[:id]
        latest_timestamp = @@events[device_id].max_by { |reading| reading[:timestamp] }[:timestamp]

        render json: { latest_timestamp: latest_timestamp }
      end

      def cumulative_count
        device_id = params[:id]
        cumulative_count = @@events[device_id].sum { |reading| reading[:count] }

        render json: { cumulative_count: cumulative_count }
      end

      private

      def reading_params
        params.require(:reading).permit(:id, readings: %i[timestamp count])
      end
    end
  end
end
