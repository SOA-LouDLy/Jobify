# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/database_helper'
require_relative '../../helpers/vcr_helper'

require_relative 'pages/home_page'
require_relative 'pages/format_page'

describe 'Format Page Acceptance Tests' do
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

  describe 'Formats Page' do
    it '(HAPPY) should see resume format 1' do
      # GIVEN: a resume is uploaded
      resume = Jobify::Affinda::ResumeMapper
        .new(RESUME_TOKEN, Jobify::Affinda::LocalApi)
        .resume(FILE)

      Jobify::Repository::For.entity(resume).create(resume)

      # WHEN: user goes directly to the formats page

      visit(FormatPage, using_params: { identifier: resume.identifier }) do |page|
        # THEN: they should see the resume formats details
        _(page.second_heading).must_equal 'Beautify your Resume'
        _(page.first_p).must_equal 'Select one of those beautifully crafted formats below and have a stunning resume. New formats added every week.'
        _(page.first_image.exists?).must_equal true
        _(page.first_card_p).must_equal 'A fan-favorite template, loved by thousands and very elegant.'
        @browser.goto "http://localhost:9000/format1/#{resume.identifier}"
      end
    end

    it '(HAPPY) should see resume format 2' do
      # GIVEN: a resume is uploaded
      resume = Jobify::Affinda::ResumeMapper
        .new(RESUME_TOKEN, Jobify::Affinda::LocalApi)
        .resume(FILE)

      Jobify::Repository::For.entity(resume).create(resume)

      # WHEN: user goes directly to the formats page
      visit(FormatPage, using_params: { identifier: resume.identifier }) do |page|
        # THEN: they should see the resume formats details
        _(page.second_image.exists?).must_equal true
        _(page.second_card_p).must_equal 'Simple, straight to point and yet so powerful.'
        @browser.goto "http://localhost:9000/format2/#{resume.identifier}"
      end
    end
  end
end
