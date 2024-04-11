# frozen_string_literal: true

require_relative '../../app/controllers/application_controller'
require_relative '../../app/controllers/api/v1/readings_controller'

file = Rails.root.join("config/#{Rails.env}_data.json")
readings = file.exist? ? JSON.parse(file.read) : {}
Api::V1::ReadingsController.events = readings
