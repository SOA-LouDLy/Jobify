# frozen_string_literal: false

module Jobify
  # Mapper to transform skill to a skill entity
  module Affinda
    # Data Mapper: Skill -> Skill entity
    class SkillMapper
      def initialize(cv_token, gateway_class = Affinda::Api)
        @key = cv_token
        @gateway_class = gateway_class
        # @gateway = @gateway_class.new(@key)
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          Jobify::Entity::Skill.new(
            organization: organization,
            accreditation: accreditation,
            grade: grade,
            formatted_location: formatted_location,
            raw_location: raw_location,
            dates: dates,
            starting_date: starting_date,
            end_date: end_date
          )
        end

        def organization
          @data['organization']
        end

        def accreditation
          @data['accreditation']['inputStr']
        end

        def grade
          @data['grade']
        end

        def formatted_location
          @data['location']['formatted']
        end

        def raw_location
          @data['location']['rawInput']
        end

        def dates
          @data['dates']
        end

        def starting_date
          dates['startDate']
        end

        def end_date
          dates['completionDate']
        end
      end
    end
  end
end
