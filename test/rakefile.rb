Dir["./test/*.rb"].each {|file| require file }

require 'rake'

task default: %w[test]

task :test do
  ruby "test/unittest.rb"
end
