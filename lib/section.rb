# frozen_string_literal: true

module Jobify
  # Model for Section in a Resume
  class Section
    def initialize(section)
      @section = section
    end

    def section_type
      @section['sectionType']
    end

    def text
      @section['text']
    end
  end
end
