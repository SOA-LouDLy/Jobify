# frozen_string_literal: false

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Github API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_job
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store job' do
    before do
      DatabaseHelper.wipe_database
    end
  end
end