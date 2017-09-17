require 'simplecov'
SimpleCov.add_filter(/_test.rb$/)
SimpleCov.add_filter(/fixture.rb$/)
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'


require_relative 'fixture'
