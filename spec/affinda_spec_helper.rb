# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../app/models/gateways_affinda/resume_api'

FILE = 'app/models/resume.pdf'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
RESUME_TOKEN = CONFIG['RESUME_TOKEN']

GOOD = YAML.safe_load(File.read('spec/fixtures/resumes_result.yml'))
DATA = GOOD['data']

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'affinda_api'
