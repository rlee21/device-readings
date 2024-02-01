# frozen_string_literal: true

module Api
  module V1
    class ReadingsController < ApplicationController
      @@events = {}

      def create
        id = event_params[:id]
        readings = event_params[:readings]

        @@events[id] ||= []

        readings.each do |reading|
          @@events[id] << reading
        end

        render status: :created
      end

      def latest_timestamp
        id = event_params[:id]
        latest_timestamp = @@events[id].max_by { |reading| reading[:timestamp] }[:timestamp]

        render json: { latest_timestamp: }
      end

      def cumulative_count
        id = event_params[:id]
        cumulative_count = @@events[id].sum { |reading| reading[:count] }

        render json: { cumulative_count: }
      end

      private

      def event_params
        params.permit(:id, readings: %i[timestamp count])
      end
    end
  end
end
