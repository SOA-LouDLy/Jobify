# string_frozen_literal: true

module Jobify
    # Model for a work experience in a resume
    class Work
      def initialize(work)
        @work = work
      end
  
      def job_title
        @work['jobTitle']
      end
  
      def organization
        @work['organization']
      end
  
      def formatted_location
        @work['location']['formatted']
      end
  
      def country
        @work['location']['country']
      end
  
      def raw_location
        @work['rawInput']
      end
  
      def dates
        @work['dates']
      end
  
      def starting_date
        dates['startDate']
      end
  
      def end_date
        dates['endDate']
      end
  
      def months_in_position
        dates['monthsInPosition']
      end
  
      def description
        @work['jobDescription']
      end
    end
  end
  