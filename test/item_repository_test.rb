require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new


    assert_instance_of ItemRepository, ir
  end
end
