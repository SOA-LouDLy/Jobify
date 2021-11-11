# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'education_entity'
require_relative 'section_entity'
require_relative 'skill_entity'
require_relative 'work_entity'

module Jobify
  module Entity
    class Resume < Dry::Struct
      attribute :certifications, Strict::String
      attribute :birth, Strict::Date
      attribute :education, Strict::Array.of(Education)
      attribute :emails, Strict::String
      attribute :formatted_location, Strict::String
      attribute :location, Strict::String
      attribute :country, Strict::String
      attribute :state, Strict::String.optional
      attribute :name, Strict::String
      attribute :objectif, Strict::String.optional
      attribute :phone_numbers, Strict::String
      attribute :sections, Strict::Array.of(Section)
      attribute :skills,   Strict::Array.of(Skill)
      attribute :languages, Strict::String
      attribute :summary, Strict::String
      attribute :websites, Strict::String.optional
      attribute :linkedin, Strict::String.optional
      attribute :total_experience, Strict::Integer
      attribute :name, Strict::String
      attribute :profession, Strict::String
      attribute :work_experience, Strict::Array.of(Work)
    end
  end
end
