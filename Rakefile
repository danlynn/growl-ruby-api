# To clean current project run: 
# 		rake clean
#
# To generate a pkg/clamav_report-1.0.0.zip:
# 		rake package
#
# To list all rake tasks:
# 		rake -T

require 'rake'
# require 'rake/packagetask'
require 'rake/testtask'
require 'rake/rdoctask'


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