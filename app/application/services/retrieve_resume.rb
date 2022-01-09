# frozen_string_literal: true

require 'dry/transaction'

module Jobify
  module Service
    # Transaction to retrieve a resume to Affinda API to database
    class RetrieveResume
      include Dry::Transaction

      # step :check_entered_file
      step :request_resume
      step :reify_resume

      private

      def request_resume(input)
        result = Gateway::Api.new(Jobify::App.config)
          .retrieve_resume(input)

        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts "#{e.inspect} + '\n' + #{e.backtrace}"
        Failure('Cannot add resumes right now; please try again later')
      end

      def reify_resume(resume_json)
        Representer::Resume.new(OpenStruct.new)
          .from_json(resume_json)
          .then { |resume| Success(resume) }
      rescue StandardError
        Failure('Error in the resume -- please try again')
      end
    end
  end
end
