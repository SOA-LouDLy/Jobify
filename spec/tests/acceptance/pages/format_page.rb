# frozen_string_literal: true

# Page object for home page
class FormatPage
  include PageObject

  page_url page_url "#{Jobify::App.config.APP_HOST}/resume/<%=params[:identifier]%>"

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h1(:second_heading, id: 'second-heading')
  p(:first_p, id: 'first-p')
  img(:first_image, id: 'first-image')
  p(:first_card_p, id: 'first-card-p')

  img(:second_image, id: 'second-image')
  p(:second_card_p, id: 'second-card-p')
end
