require 'SimpleCov'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'

SimpleCov.start do
  add_filter './test'
end
