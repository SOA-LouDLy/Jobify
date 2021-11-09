# frozen_string_literal: true

module Jobify
  # Model for Resume
  class Resume
    def initialize(resume)
      @resume = resume['data']
    end

    def certifications
      @resume['certifications']
    end

    def birth
      @resume['dateOfBirth']
    end

    def education
      @resume['education'].map { |education| Education.new(education) }
    end

    def emails
      @resume['emails']
    end

    def formatted_location
      @resume['location']['formatted']
    end

    def location
      @resume['location']['rawInput']
    end

    def country
      @resume['country']
    end

    def state
      @resume['state']
    end

    def name
      @resume['raw']
    end

    def objective
      @resume['objective']
    end

    def phone_numbers
      @resume['phoneNumbers']
    end

    def sections
      @resume['sections'].map { |section| Section.new(section) }
    end

    def skills
      @resume['skills'].map { |skill| Skill.new(skill) }
    end

    def languages
      @resume['languages']
    end

    def summary
      @resume['summary']
    end

    def websites
      @resume['websites']
    end

    def linkedin
      @resume['linkedin']
    end

    def total_experience
      @resume['totalYearsExperience']
    end

    def profession
      @resume['profession']
    end

    def work_experience
      @resume['workExperience'].map { |work| Work.new(work) }
    end
  end
end
