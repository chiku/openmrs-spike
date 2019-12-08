require 'rspec/core/rake_task'
require 'jasmine'
require 'sprockets'

load 'jasmine/tasks/jasmine.rake'

desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w{--colour --format progress}
    t.pattern = 'spec/**/*_spec.rb'
  end
end

desc "Minify javascript and stylesheet files"
task :minify do
  sprockets = Sprockets::Environment.new do |env|
    env.logger = Logger.new(STDOUT)
    env.js_compressor = :uglify
    env.css_compressor = :sass
  end

  sprockets.append_path('public/javascripts')
  sprockets.append_path('public/stylesheets')
  js_assets = sprockets.find_asset('all.js')
  css_assets = sprockets.find_asset('all.css')

  js_assets.write_to('public/javascripts/all.min.js')
  css_assets.write_to('public/stylesheets/all.min.css')
end

task :default => [:spec, :'jasmine:ci']
