# frozen_string_literal: true

require 'curb'
require 'yaml'
require 'http'
require_relative 'education'
require_relative 'resume'
require_relative 'section'
require_relative 'skill'
require_relative 'work'

module Jobify
  # Library for Affinda API
  class AffindaApi
    # API_RESUME_ROOT = 'https://api.affinda.com/v1/resumes/'

    def initialize(id)
      @id = id
    end

    def resume(file)
      resume_data = Request.new(@id, file).resume
      Resume.new(resume_data)
    end

    # Sends POST request to Affinda API and GETs the response
    class Request
      def initialize(key, file)
        @key = key
        @file = file
      end

      def resume
        c = Curl::Easy.new('https://api.affinda.com/v1/resumes/')
        c.headers['Authorization'] = "Bearer #{@key}"
        c.multipart_form_post = true
        c.http_post(Curl::PostField.file('file', @file))
        JSON.parse(c.body)
      end
    end
  end
end
