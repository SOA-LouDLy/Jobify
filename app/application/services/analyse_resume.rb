# frozen_string_literal: true

require 'dry/transaction'

module Jobify
  module Service
    # Analyzes a resume
    class AnalyseResume
      include Dry::Transaction

      step :validate_resume
      step :retrieve_resume_analysis
      step :reify_resume_analysis

      def validate_resume(input)
        if input[:watched_list].include? input[:identifier]
          Success(input)
        else
          Failure('Please first request this resume to be added to your list')
        end
      end

      def retrieve_resume_analysis(input)
        result = Gateway::Api.new(Jobify::App.config)
          .analyse_resume(input[:identifier])

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError
        Failure('Cannot analyse resumes right now; please try again later')
      end

      def reify_resume_analysis(resume_analysis_json)
        Representer::ResumeAnalysis.new(OpenStruct.new)
          .from_json(resume_analysis_json)
          .then { |analysis| Success(analysis) }
      rescue StandardError
        Failure('Error in our analysis report -- please try again')
      end
    end
  end
end
