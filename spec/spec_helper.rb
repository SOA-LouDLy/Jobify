# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'
require_relative '../lib/job_api'
require 'careerjet/api_client'

SKILL = 'ruby'
LOCATION = 'london'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
JOB_TOKEN = CONFIG['API_KEY']

GOOD = YAML.safe_load(File.read('spec/fixtures/job_results.yml'),
                      permitted_classes: [Careerjet::Mash, Hashie::Array])
CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'job_api'
