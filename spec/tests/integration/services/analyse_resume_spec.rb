# frozen_string_literal: true

require_relative '../../../helpers/spec_helper'
describe 'Integration test of AddResume service and API gateway' do
  it 'must get the analysis of an existing resume' do
    resume_made = Jobify::Service::AddResume.new.call(FILE)

    req = OpenStruct.new(
      identifier: resume_made.value!.identifier
    )
    watched_list = [req.identifier]
    # WHEN we request to add a resume
    res = Jobify::Service::AnalyseResume.new.call(
      watched_list: watched_list, identifier: req.identifier
    )
    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    analysis = res.value!
    _(analysis.resume.name).must_equal NAME
    _(analysis.resume.phone_numbers[0].number).must_equal PHONE
  end
end
