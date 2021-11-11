# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module Jobify
  module Entity
    class Work < Dry::Struct
      attribute :job_title, Strict::String
      attribute :organization, Strict::String
      attribute :formatted_location, Strict::String
      attribute :country, Strict::String.optional
      attribute :raw_location,  Strict::String
      attribute :dates,         Strict::Date
      attribute :starting_date, Strict::Date
      attribute :end_date, Strict::Date
      attribute :months_in_position,  Strict::Integer
      attribute :description, Strict::String
    end
  end
end
