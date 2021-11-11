# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module Jobify
  module Entity
    class Skill < Dry::Struct
      attribute :name, Strict::String
      attribute :experience, Strict::String.optional
      attribute :type, Strict::String
    end
  end
end
