# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/resume_api'

FILE = '../lib/resume.pdf'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
RESUME_TOKEN = CONFIG['RESUME_TOKEN']

GOOD = YAML.safe_load(File.read('spec/fixtures/resumes_resul.yml'))
DATA = GOOD['data']

describe 'Education information' do
    before do
      @resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                 .resume(FILE)
      @educations_data = DATA.map {|education| Jobify::Education.new(education)}
      @education = @resume.education
    end

    it 'HAPPY: should recognize education' do
      _(@resume.education).must_be_kind_of Jobify::Education
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

describe 'Tests Affinda API library' do
  describe 'Resume information' do
    it 'HAPPY: should provide correct resume attributes' do
      resume = Jobify::AffindaApi.new(RESUME_TOKEN)
                                 .resume(FILE)
       
      _(resume.name).must_equal DATA['name']['raw']
      _(resume.birth).must_equal DATA['dateOfBirth']
      _(resume.emails).must_equal DATA['emails']
      _(resume.formatted_location).must_equal DATA['location']['formatted']
      _(resume.location).must_equal DATA[['location']['rawInput']
      _(resume.country).must_equal DATA['country']
      _(resume.state).must_equal DATA['state']
      _(resume.phone_numbers).must_equal DATA['phoneNumbers']
      _(resume.languages).must_equal DATA['languages']
      _(resume.summary).must_equal DATA['summary']
      _(resume.linkedin).must_equal DATA['linkedin']
      _(resume.total_experience).must_equal DATA['totalYearsExperience']
      _(resume.profession).must_equal DATA['profession']
      _(resume.websites).must_equal DATA['websites']
      _(resume.websites).must_equal DATA['websites']
    

    def education
      @resume['education'].map { |education| Education.new(education) }
    end

    def sections
      @resume['sections'].map { |section| Section.new(section) }
    end

    def skills
      @resume['skills'].map { |skill| Skill.new(skill) }
    end

    def work_experience
      @resume['workExperience'].map { |work| Work.new(work) }
    end

    end
  end
end
