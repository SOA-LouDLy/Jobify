# frozen_string_literal: false

module Jobify
  # Mapper to transform section to a section entity
  module Affinda
    # Data Mapper: Section -> Section entity
    class ResumeMapper
      def initialize(cv_token, gateway_class = Affinda::Api)
        @key = cv_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@key)
      end

      def self.build_entity(data)
        DataMapper.new(data, @key, @gateway_class).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          Jobify::Entity::Resume.new(
            certifications: certifications,
            birth: birth,
            education: education,
            emails: emails,
            formatted_location: formatted_location,
            location: location,
            country: country,
            state: state,
            name: name,
            objective: objective,
            phone_numbers: phone_numbers,
            sections: sections,
            skills: skills,
            languages: languages,
            summary: summary,
            websites: websites,
            linkedin: linkedin,
            total_experience: total_experience,
            profession: profession,
            work_experience: work_experience
          )
        end

        def certifications
          @data['certifications']
        end

        def birth
          @data['dateOfBirth']
        end

        def education
          EducationMapper.build_entity(@data['education'])
        end

        def emails
          @data['emails']
        end

        def formatted_location
          @data['location']['formatted']
        end

        def location
          @data['location']['rawInput']
        end

        def country
          @data['country']
        end

        def state
          @data['state']
        end

        def name
          @data['name']['raw']
        end

        def objective
          @data['objective']
        end

        def phone_numbers
          @data['phoneNumbers']
        end

        def sections
          SectionMapper.build_entity(@data['sections'])
        end

        def skills
          SkillsMapper.build_entity(@data['skills'])
        end

        def languages
          @data['languages']
        end

        def summary
          @data['summary']
        end

        def websites
          @data['websites']
        end

        def linkedin
          @data['linkedin']
        end

        def total_experience
          @data['totalYearsExperience']
        end

        def profession
          @data['profession']
        end

        def work_experience
          WorkExperienceMapper.build_entity(@data['work_experience'])
        end
      end
    end
  end
end
