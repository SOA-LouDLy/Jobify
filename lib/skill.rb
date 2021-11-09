# frozen_string_literal: true

module Jobify
    # Model for skill in a Resume
    class Skill
      def initialize(skill)
        @skill = skill
      end
  
      def name
        @skill['name']
      end
  
      def experience
        @skill['numberOfMonths']
      end
  
      def type
        @skill['type']
      end
    end
  end
  