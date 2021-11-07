# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'
require_relative '../lib/resume_info'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
RESUME_TOKEN = CONFIG['CV_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/resume_result.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'resume_info'
