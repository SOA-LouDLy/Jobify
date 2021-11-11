# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module Jobify
  module Entity
    class Education < Dry::Struct
      include Dry.Types

      attribute :organization, Strict::String
      attribute :accreditation, Strict::String
      attribute :grade, Strict::Integer.optional
      attribute :formatted_location, Strict::String
      attribute :raw_location,  Strict::String
      attribute :dates,         Strict::Date
      attribute :starting_date, Strict::Date
      attribute :end_date, Strict::Date
    end
  end
end
