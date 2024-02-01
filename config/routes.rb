# frozen_string_literal: true

Rails.application.routes.draw do
  get '/-/health', to: 'health#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/readings', to: 'readings#create'
      get '/readings/latest_timestamp', to: 'readings#latest_timestamp'
      get '/readings/cumulative_count', to: 'readings#cumulative_count'
    end
  end
end
