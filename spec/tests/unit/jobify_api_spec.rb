# frozen_string_literal: true

require_relative '../../helpers/spec_helper'

describe 'Unit test of Jobify API gateway' do
  it 'must report alive status' do
    alive = Jobify::Gateway::Api.new(Jobify::App.config).alive?
    _(alive).must_equal true
  end

  it 'must be able to add a resume' do
    res = Jobify::Gateway::Api.new(Jobify::App.config)
      .add_resume(FILE)

    _(res.success?).must_equal true
    _(res.parse.keys.count).must_be :>=, 5
  end

  it 'must return a list of resumes' do
    # WHEN we request a list of resumes
    list = [IDENTIFIER]
    res = Jobify::Gateway::Api.new(Jobify::App.config)
      .resumes_list(list)

    # THEN we should see a single resume in the list
    _(res.success?).must_equal true
    data = res.parse
    _(data.keys).must_include 'resumes'
    _(data['resumes'].count).must_equal 1
    _(data['resumes'].first.keys.count).must_be :>=, 5
  end
end
