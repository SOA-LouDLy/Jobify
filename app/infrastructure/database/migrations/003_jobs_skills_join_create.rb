# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:jobs_skills) do
      primary_key[:job_id, :skill_id]
      foreign_key :skill_id, :skills
      foreign_key :job_id, :jobs

      index [:skill_id, :job_id]
    end
  end
end
