# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Tests AFFINDA API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<CV_TOKEN>') { RESUME_TOKEN }
    c.filter_sensitive_data('<CV_TOKEN_ESC>') { CGI.escape(RESUME_TOKEN) }
  end
  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end
end
