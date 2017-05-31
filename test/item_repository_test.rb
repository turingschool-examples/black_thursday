require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test

  def test_if_create_class
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end



end
