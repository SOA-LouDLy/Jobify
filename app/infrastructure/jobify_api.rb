# frozen_string_literal: true

require_relative 'list_request'
require 'http'
require 'base64'
require 'json'
require 'httmultiparty'

module Jobify
  module Gateway
    # Infrastructure to call Jobify API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def resumes_list(list)
        @request.resumes_list(list)
      end

      def add_resume(resume)
        @request.add_resume(resume)
      end

      def retrieve_resume(id)
        @request.retrieve_resume(id)
      end

      def analyse_resume(identifier)
        @request.analyse_resume(identifier)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = "#{config.API_HOST}/api/v1"
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def resumes_list(list)
          call_api('get', ['resumes'],
                   'list' => Value::WatchedList.to_encoded(list))
        end

        def add_resume(resume)
          call_api_to_post('resumes', resume)
        end

        def analyse_resume(identifier)
          call_api('get', ['resumes', identifier])
        end

        def retrieve_resume(id)
          call_api('get', ['resumes', id])
        end

        # Add function to be able to get analysis from API

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
            .then { |str| str ? '?' + str : '' }
        end

        def call_api_to_post(resource, param)
          url = "#{@api_root}/#{resource}"
          pdf_str = File.read(param)
          pdf_encoded = Base64.encode64(pdf_str)
          # json_pdf = pdf_encoded.to_json
          HTTP.headers('Accept' => 'application/json').post(url, json: { 'pdf64' => pdf_encoded })
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)
          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299)

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          payload['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end
