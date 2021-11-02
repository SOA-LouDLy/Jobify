require 'curb'
require 'yaml'

config = YAML.safe_load(File.read('config/secrets.yml'))

file = File.open('lib/resume.pdf', 'rb', &:read)
c = Curl::Easy.new('https://api.affinda.com/v1/resumes/')
c.headers['Authorization'] = "Bearer #{config['CV_TOKEN']}"
c.multipart_form_post = true
c.http_post(Curl::PostField.file('file', 'lib/resume.pdf'))
puts c.body
