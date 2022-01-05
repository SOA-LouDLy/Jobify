# frozen_string_literal: true

folders = %w[representers services controllers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
