# frozen_string_literal: true

require 'curb'
require 'yaml'
require 'http'

module Jobify
  # Library for Affinda API
  class AffindaApi
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
      c = Curl::Easy.new('https://api.affinda.com/v1/resumes/')
      c.headers['Authorization'] = "Bearer #{@key}"
      c.multipart_form_post = true
      c.http_post(Curl::PostField.file('file', @file))
      JSON.parse(c.body)
    end
  end
end
