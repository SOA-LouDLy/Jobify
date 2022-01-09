# frozen_string_literal: true

require_relative '../../../helpers/spec_helper'
describe 'Integration test of ListResumes service and API gateway' do
  it 'must return a list of resumes' do
    # WHEN we request a list of reesumes
    resume_made = Jobify::Service::AddResume.new.call(FILE)
    list = [resume_made.value!.identifier]
    res = Jobify::Service::ListResumes.new.call(list)

    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.resumes.count).must_equal 1
    _(list.resumes.first.name).must_equal NAME
  end
  it 'must return and empty list if we specify none' do
    # WHEN we request a list of resumes
    list = []
    res = Jobify::Service::ListResumes.new.call(list)

    # THEN we should see a no projects in the list
    _(res.success?).must_equal true
    list = res.value!
    _(list.resumes.count).must_equal 0
  end
end
