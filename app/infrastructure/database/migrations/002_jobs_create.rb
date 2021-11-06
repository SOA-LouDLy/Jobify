# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:jobs) do
      primary_key :id
      foreign_key :link_id, :links

      String      :title null:false
      String      :date
      String      :description
      String      :company
      String      :locations
      
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
