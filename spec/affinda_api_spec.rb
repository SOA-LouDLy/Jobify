# frozen_string_literal: true

require 'curb'

require_relative 'affinda_spec_helper'

describe 'Tests Github API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<AFFINDA_TOKEN>') { RESUME_TOKEN }
    c.filter_sensitive_data('<AFFINDA_TOKEN_ESC>') { CGI.escape(RESUME_TOKEN) }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Resume information' do
    it 'HAPPY: should provide correct resume attributes' do
      resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                 .resume(FILE)

      _(resume.name).must_equal DATA['name']['raw']
      _(resume.certifications).must_equal DATA['certifications']
      _(resume.birth).must_equal DATA['dateOfBirth']
      _(resume.emails).must_equal DATA['emails']
      _(resume.formatted_location).must_equal DATA['location']['formatted']
      _(resume.location).must_equal DATA['location']['rawInput']
      _(resume.country).must_equal DATA['country']
      _(resume.state).must_equal DATA['state']
      _(resume.phone_numbers).must_equal DATA['phoneNumbers']
      _(resume.languages).must_equal DATA['languages']
      _(resume.summary).must_equal DATA['summary']
      _(resume.linkedin).must_equal DATA['linkedin']
      _(resume.total_experience).must_equal DATA['totalYearsExperience']
      _(resume.profession).must_equal DATA['profession']
      _(resume.websites).must_equal DATA['websites']
      _(resume.objective).must_equal DATA['objective']
    end
  end

  describe 'Education information' do
    before do
      @resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                  .resume(FILE)
      @educations_data = DATA['education'].map { |education| Jobify::Education.new(education) }
      @education = @resume.education
    end

    it 'HAPPY: should recognize education' do
      _(@education[0]).must_be_kind_of Jobify::Education
    end

    it 'HAPPY: should verify education information' do
      @educations_data.each.with_index do |education, index|
        _(@education[index].organization).must_equal education.organization
        _(@education[index].accreditation).must_equal education.accreditation
        _(@education[index].grade).must_equal education.grade
        _(@education[index].formatted_location).must_equal education.formatted_location
        _(@education[index].raw_location).must_equal education.raw_location
        _(@education[index].dates).must_equal education.dates
        _(@education[index].starting_date).must_equal education.starting_date
        _(@education[index].end_date).must_equal education.end_date
      end
    end
  end

  describe 'Section information' do
    before do
      @resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                  .resume(FILE)
      @sections_data = DATA['sections'].map { |section| Jobify::Section.new(section) }
      @sections = @resume.sections
    end

    it 'HAPPY: should recognize education' do
      _(@sections[0]).must_be_kind_of Jobify::Section
    end

    it 'HAPPY: should verify section information' do
      @sections_data.each.with_index do |section, index|
        _(@sections[index].section_type).must_equal section.section_type
        _(@sections[index].text).must_equal section.text
      end
    end
  end

  describe 'Skill information' do
    before do
      @resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                  .resume(FILE)
      @skills_data = DATA['skills'].map { |skill| Jobify::Skill.new(skill) }
      @skills = @resume.skills
    end

    it 'HAPPY: should recognize skill' do
      _(@skills[0]).must_be_kind_of Jobify::Skill
    end

    it 'HAPPY: should verify section information' do
      @skills_data.each.with_index do |skill, index|
        _(@skills[index].name).must_equal skill.name
        _(@skills[index].experience).must_equal skill.experience
        _(@skills[index].type).must_equal skill.type
      end
    end
  end

  describe 'Work information' do
    before do
      @resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                  .resume(FILE)
      @work_data = DATA['workExperience'].map { |work| Jobify::Work.new(work) }
      @work = @resume.work_experience
    end

    it 'HAPPY: should recognize education' do
      _(@work[0]).must_be_kind_of Jobify::Work
    end

    it 'HAPPY: should verify section information' do
      @work_data.each.with_index do |work, index|
        _(@work[index].job_title).must_equal work.job_title
        _(@work[index].organization).must_equal work.organization
        _(@work[index].formatted_location).must_equal work.formatted_location
        _(@work[index].country).must_equal work.country
        _(@work[index].raw_location).must_equal work.raw_location
        _(@work[index].dates).must_equal work.dates
        _(@work[index].starting_date).must_equal work.starting_date
        _(@work[index].end_date).must_equal work.end_date
        _(@work[index].months_in_position).must_equal work.months_in_position
        _(@work[index].description).must_equal work.description
      end
    end
  end
end
