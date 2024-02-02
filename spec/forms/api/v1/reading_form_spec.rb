# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe Api::V1::ReadingForm do
      subject(:form) { described_class.new(params) }

      describe 'validations' do
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

          it 'returns true' do
            expect(form.valid?).to be(true)
          end
        end

        context 'when id param is missing' do
          let(:params) do
            {
              readings: [
                { timestamp: '2021-09-29T16:08:15+01:00', count: 2 },
                { timestamp: '2021-09-29T16:09:15+01:00', count: 15 }
              ]
            }
          end

          it 'returns false' do
            expect(form.valid?).to be(false)
          end
        end

        context 'when readings param is missing' do
          let(:params) { { id: '16d5658a-6908-479e-887e-a949ec199272' } }

          it 'returns false' do
            expect(form.valid?).to be(false)
          end
        end

        context 'when readings param is not an array' do
          let(:params) do
            {
              id: '16d5658a-6908-479e-887e-a949ec199272',
              readings: 'string'
            }
          end

          it 'returns false' do
            expect(form.valid?).to be(false)
          end
        end

        context 'when readings param is not an array of hashes' do
          let(:params) do
            {
              id: '16d5658a-6908-479e-887e-a949ec199272',
              readings: %w[foo bar]
            }
          end

          it 'returns false' do
            expect(form.valid?).to be(false)
          end
        end
      end
    end
  end
end
