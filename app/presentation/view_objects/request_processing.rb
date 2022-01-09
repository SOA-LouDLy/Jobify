# frozen_string_literal: true

module Views
  # View object to capture progress bar information
  class RequestProcessing
    def initialize(config, request)
      @config = config
      @request = request
    end

    def ws_channel_id
      @request.request_id
    end

    def ws_javascript
      @config.API_HOST + '/faye/faye.js'
    end

    def ws_route
      @config.API_HOST + '/faye/faye'
    end

    def resume
      @request.id.to_i
    end
  end
end
