require 'simplecov'

SimpleCov.start do
    add_filter "test"
end

require 'pry'
require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/emoji'
require 'bigdecimal'
require 'reek'
require 'cane'
require 'minitest/mock'
require 'time'