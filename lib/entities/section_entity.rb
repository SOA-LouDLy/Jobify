# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module Jobify
  module Entity
    class Section < Dry::Struct
      attribute :section_type, Strict::String.optional
      attribute :text, Strict::String.optional
    end
  end
end
