# To clean current project run: 
# 		rake clean
#
# To generate a pkg/clamav_report-1.0.0.zip:
# 		rake package
#
# To list all rake tasks:
# 		rake -T

$:.unshift File.dirname(__FILE__) + '/lib/'
require 'rake'
# require 'rake/packagetask'
require 'rake/testtask'
require 'rake/rdoctask'
require 'growl'


Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end


Rake::RDocTask.new do |rd|
  # rd.main = "README.rdoc"
  rd.rdoc_files.include("**/*.rb")
  rd.rdoc_files.exclude("test")
  rd.options << "--inline-source"
  rd.rdoc_dir = "docs"
end

desc 'Generate gemspec'
task :gemspec do |t|
  open('growl-ruby-api.gemspec', "wb" ) do |file|
    file << <<-EOS
Gem::Specification.new do |s|
  s.name = 'growl-ruby-api'
  s.version = '#{GrowlRubyApi::Growl::VERSION}'
  s.summary = "Unified growl interface"
  s.description = "A single unified interface to growl combining local/remote notifications and even a Logger wrapper."
  s.files = %w( #{Dir['lib/**/*.rb'].join(' ')}
                #{Dir['examples/**/*.rb'].join(' ')}
                Rakefile )
  s.author = 'Dan Lynn And Greg Stickley'
  s.email = 'dan@danlynn.org'
  s.homepage = 'http://github.com/danlynn/growl-ruby-api'
end
    EOS
  end
  puts "Generate gemspec"
end

desc 'Generate gem'
task :gem => :gemspec do |t|
  system 'gem', 'build', 'growl-ruby-api.gemspec'
end
