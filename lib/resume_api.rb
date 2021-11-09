# frozen_string_literal: true

require 'curb'
require 'yaml'
require 'http'

module Jobify
  # Library for Affinda API
  class AffindaApi
    API_RESUME_ROOT = 'https://api.affinda.com/v1/resumes/'

    module Errors
      class Unauthorized < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
    }.freeze

    def initialize(id)
      @id = id
    end

    def resume(file)
      resume_data = Request.new(@id, file).resume
      Resume.new(resume_data)
    end
  end

  # Sends POST request to Affinda API and GETs the response
  class Request
    def initialize(key, file)
      @key = key
      @file = file
    end

    def resume
      c = Curl::Easy.new(API_RESUME_ROOT)
      c.headers['Authorization'] = "Bearer #{@key}"
      c.multipart_form_post = true
      c.http_post(Curl::PostField.file('file', @file))
      result = JSON.parse(c.body)

      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
