#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'

MODEL_FILES = Dir[File.join(File.dirname(__FILE__), 'lib', 'models', '*.rb')]
MODEL_FILES.each {|file| require file }

module PatientsManagament
  class Application < Sinatra::Base
    index_file = 'index.dev.html'

    configure :development, :test do
      register Sinatra::Reloader
      MODEL_FILES.each {|file| puts file }
      MODEL_FILES.each {|file| also_reload file }
      index_file = 'index.min.html'
    end

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      [username, password] == ['developer', '!abcd1234']
    end

    get "/" do
      File.read(File.join('public', index_file))
    end

    get "/patients.json" do
      content_type 'application/json'
      ({:patients => Patient.all}).to_json
    end

    get "/patients/:id.json" do
      content_type 'application/json'
      Patient.find(params[:id]).to_json
    end
  end
end
