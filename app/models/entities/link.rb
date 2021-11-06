# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module Jobify
  module Entity
    # Skill Entity
    class Link < Dry::Struct
      include Dry.types
      
      attribute :id, Integer.optional
      attribute :url, Strict::String

      def to_attr_hash
        to_hash.reject {|key, _| [:id].include? key}
      end
    end
  end
end
