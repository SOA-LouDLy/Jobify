# frozen_string_literal: true

require 'dry/transaction'

module Jobify
  module Service
    # Retrieves array of all listed resume entities
    class ListResumes
      include Dry::Transaction

      step :get_api_list
      step :reify_list

      private

      def get_api_list(resumes_list)
        Gateway::Api.new(Jobify::App.config)
          .resumes_list(resumes_list)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_list(resumes_json)
        Representer::ResumesList.new(OpenStruct.new)
          .from_json(resumes_json)
          .then { |resumes| Success(resumes) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
