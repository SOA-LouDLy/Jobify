# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url Jobify::App.config.APP_HOST

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h1(:title_heading, id: 'main_header')
  form(:show_formats, id: 'show-formats')
  file_field(:resume_upload, id: 'resume_upload')
  button(:add_button, id: 'cv-submit')
  table(:resumes_table, id: 'resumes_table')

  def first_resume
    resumes[0]
  end

  def add_new_resume
    add_button
  end

  def first_resume_row
    resumes_table_element.trs[1]
  end

  def first_resume_delete
    first_resume_row.button(id: 'resume[0].delete').click
  end
end
