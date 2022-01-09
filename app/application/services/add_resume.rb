# frozen_string_literal: true

require 'dry/transaction'

module Jobify
  module Service
    # Transaction to upload a resume to Affinda API to database
    class AddResume
      include Dry::Transaction
      # step :check_entered_file
      step :request_resume
      step :reify_request
      private
      def request_resume(input)
        result = Gateway::Api.new(Jobify::App.config)
          .add_resume(input)
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts "#{e.inspect} + '\n' + #{e.backtrace}"
        Failure('Cannot add resumes right now; please try again later')
      end
      def reify_request(request_json)
        Representer::UploadRequest.new(OpenStruct.new)
          .from_json(request_json)
          .then { |request| Success(request) }
      rescue StandardError
        Failure('Error in the request -- please try again')
      end
    end
  end
end