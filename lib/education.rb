# frozen_string_literal: true

module Jobify
    # Model for Education in a Resume
    class Education
      def initialize(education)
        @education = education
      end
  
      def organization
        @education['organization']
      end
  
      def accreditation
        @education['accreditation']['inputStr']
      end
  
      def grade
        @education['grade']
      end
  
      def formatted_location
        @education['location']['formatted']
      end
  
      def raw_location
        @education['location']['rawInput']
      end
  
      def dates
        @education['dates']
      end
  
      def starting_date
        dates['startDate']
      end
  
      def end_date
        dates['completionDate']
      end
    end
  end
  