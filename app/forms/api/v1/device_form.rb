# frozen_string_literal: true

module Api
  module V1
    class DeviceForm
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :string
      attribute :readings, array: true

      validates_presence_of :id, :readings

      validates_each :id do |record, attribute, value|
        record.errors.add attribute, 'id must be a string' unless value.is_a?(String)
      end

      validates_each :readings do |record, attribute, value|
        record.errors.add attribute, 'readings must be an array' unless value.is_a?(Array)
      end
    end
  end
end
