# frozen_string_literal: false

module Jobify
    # Mapper to transform section to a section entity
    module Affinda
      # Data Mapper: Section -> Section entity
      class SectionMapper
        def initialize(cv_token, gateway_class = Affinda::Api)
          @key = cv_token
          @gateway_class = gateway_class
          @gateway = @gateway_class.new(@key)
        end
  
        def self.build_entity(data)
          DataMapper.new(data).build_entity
        end
  
        # Extracts entity specific elements from data structure
        class DataMapper
          def initialize(data)
            @data = data
          end
  
          def build_entity
            Entity::Section.new(
              section_type: section_type,
              text: text
            )
          end
  
          def section_type
            @section['sectionType']
          end
  
          def text
            @section['text']
          end
        end
      end
    end
  end
  