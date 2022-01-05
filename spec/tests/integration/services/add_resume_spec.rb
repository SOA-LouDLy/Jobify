# frozen_string_literal: true

require_relative '../../../helpers/spec_helper'

describe 'Integration test of AddResume service and API gateway' do
  it 'must add a legitimate resume' do
    # WHEN we request to add a project
    res = Jobify::Service::AddResume.new.call(FILE)

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    resume = res.value!
    _(resume['total_experience']).must_equal 4
    _(resume['profession']).must_include 'Web'
    _(resume['name']).must_equal 'CHRISTOPHER MORGAN'
    _(resume['summary']).must_include 'Senior Web Developer'
  end
end
