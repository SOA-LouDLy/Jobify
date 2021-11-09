require 'curb'
require 'yaml'
require 'http'

config = YAML.safe_load(File.read('config/secrets.yml'))

c = Curl::Easy.new('https://api.affinda.com/v1/resumes/')
c.headers['Authorization'] = "Bearer #{config['CV_TOKEN']}"
c.multipart_form_post = true
c.http_post(Curl::PostField.file('file', 'lib/resume.pdf'))
results = JSON.parse(c.body)

File.write('spec/fixtures/resumes_result.yml', results.to_yaml)
