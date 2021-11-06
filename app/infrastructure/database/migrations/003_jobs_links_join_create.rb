# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:jobs_links) do
      primary_key[:job_id, :link_id]
      foreign_key :link_id, :links
      foreign_key :job_id, :jobs

      index [:link_id, :job_id]
    end
  end
end
