# frozen_string_literal: true

require 'figaro'
require 'roda'
require 'sequel'
require 'yaml'
require 'delegate'

module Jobify
  # Configuration for the App
  class App < Roda
    plugin :environments
    # Environment variables setup
    Figaro.application = Figaro::Application.new(
      environment: environment,
      path: File.expand_path('config/secrets.yml')
    )
    Figaro.load
    def self.config() = Figaro.env

    use Rack::Session::Cookie, secret: config.SESSION_SECRET

    configure :development, :test, :app_test do
      require 'pry'
    end
  end
end
