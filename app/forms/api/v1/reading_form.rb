# frozen_string_literal: true

module Api
  module V1
    class ReadingForm
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :timestamp, :datetime
      attribute :count, :integer

      validates_presence_of :timestamp, :count
      validates_numericality_of :count, only_integer: true

      validates_each :readings do |record, attribute, value|
        record.errors.add attribute, 'readings must be a hash' unless value.is_a?(Hash)
      end
    end
  end
end
