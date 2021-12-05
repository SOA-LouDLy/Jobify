# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/database_helper'
require_relative '../../helpers/vcr_helper'

require_relative 'pages/home_page'

describe 'Homepage Acceptance Tests' do
  include PageObject::PageFactory

  before do
    DatabaseHelper.wipe_database
    # @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Visit Home page' do
    it '(HAPPY) should not see resumes if none created' do
      # GIVEN: user is on the home page without any projects
      visit HomePage do |page|
        # THEN: user should see basic headers, no projects and a welcome message
        _(page.title_heading).must_equal 'JOBIFY'
        _(page.show_formats.present?).must_equal true
        _(page.resume_upload.exists?).must_equal true
        _(page.add_button.present?).must_equal true
        _(page.resumes_table.exists?).must_equal false
      end
    end

    it '(HAPPY) should not see projects they did not request' do
      # GIVEN: a resume exists in the database but user has not requested it
      resume = Jobify::Affinda::ResumeMapper
        .new(RESUME_TOKEN, Jobify::Affinda::LocalApi)
        .resume(FILE)
      Jobify::Repository::For.entity(resume).create(resume)

      # WHEN: user goes to the homepage
      visit HomePage do |page|
        # THEN: they should not see any resumes
        _(page.resumes_table_element.exists?).must_equal false
      end
    end

    describe 'Add resume' do
      it '(HAPPY) should be able to upload a resume' do
        # GIVEN:  user is on the home page without any resume
        resume = Jobify::Affinda::ResumeMapper
          .new(RESUME_TOKEN, Jobify::Affinda::LocalApi)
          .resume(FILE)
        Jobify::Repository::For.entity(resume).create(resume)

        visit HomePage do |page|
          # WHEN: they upload a resume and submit
          page.add_new_resume

          # THEN: they should find themselves on the resume's page
          @browser.url.include? resume.identifier
        end
      end
    end

    describe 'Delete Resume' do
      it '(HAPPY) should be able to delete a requested resume' do
        # GIVEN: user has requested and created a single resume
        resume = Jobify::Affinda::ResumeMapper
          .new(RESUME_TOKEN, Jobify::Affinda::LocalApi)
          .resume(FILE)
        Jobify::Repository::For.entity(resume).create(resume)

        visit HomePage, &:add_new_resume

        # WHEN: they revisit the homepage and delete the project
        visit HomePage do |page|
          page.resumes_table.exists? ? @page.first_resume_delete : false
          # @browser.button(id: 'resume[0].delete').click
          # THEN: they should not find any resume
          _(resumes_table_element.exists?).must_equal false
        end
      end
    end
  end
end
