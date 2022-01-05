# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module Jobify
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :public, root: 'app/presentation/public'
    plugin :assets, path: 'app/presentation/assets',
                    css: { format1: 'format1.css',
                           format2: 'format2.css',
                           layout: 'style.css',
                           formats: 'formats.css' }, js: 'table_row_click.js'
    plugin :halt
    plugin :flash
    plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    # plugin :render, engine: 'slim', views: 'app/presentation/views_html'

    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs)

    # rubocop:disable Metrics/BlockLength
    route do |routing|
      routing.assets # load CSS
      routing.public
      # GET /
      routing.root do
        # view 'home'

        # Get Cookie Viewwer's
        session[:watching] ||= []

        result = Service::ListResumes.new.call(session[:watching])
        if result.failure?
          viewable_resume = []
        else
          resumes = result.value!.resumes
          session[:watching] = resumes.map(&:identifier)
          viewable_resume = Views::ResumesList.new(resumes)
        end

        view 'home', locals: { resumes: viewable_resume }
      end

      routing.on 'formats' do
        routing.is do
          # Form Post to /formats/
          routing.post do
            unless routing[:file] &&
                   (tmpfile = routing[:file][:tempfile]) &&
                   (name = routing[:file][:filename])
            end
            warn "Uploading file, original name #{name.inspect}"
            resume_made = Service::AddResume.new.call(tmpfile)
            routing.redirect '/' if resume_made.failure?

            resume = resume_made.value!
            # Add new resume to watched set in cookies
            session[:watching].insert(0, resume.identifier).uniq!
            routing.redirect "/formats/#{resume.identifier}"
          end
        end

        routing.on String do |identifier|
          # GET /formats/{identifier}
          routing.get do
            view 'formats', locals: { identifier: identifier }
          end
        end
      end

      routing.on 'format1' do
        routing.on String do |identifier|
          routing.delete do
            session[:watching].delete(identifier)

            routing.redirect '/'
          end
          result = Service::AnalyseResume.new.call(
            watched_list: session[:watching],
            identifier: identifier
          )
          routing.redirect '/' if result.failure?

          analyzed = result.value!

          routing.redirect '/' if analyzed.nil?

          resume_analysis = Views::ResumeAnalysis.new(
            analyzed[:resume], analyzed[:analysis]
          )
          view 'format1', locals: { analysis: resume_analysis }
        end
      end

      routing.on 'format2' do
        routing.on String do |identifier|
          result = Service::AnalyseResume.new.call(
            watched_list: session[:watching],
            identifier: identifier
          )
          routing.redirect '/' if result.failure?
          analyzed = result.value!
          routing.redirect '/' if analyzed.nil?

          resume_analysis = Views::ResumeAnalysis.new(
            analyzed[:resume], analyzed[:analysis]
          )
          view 'format2', locals: { analysis: resume_analysis }
        end
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
