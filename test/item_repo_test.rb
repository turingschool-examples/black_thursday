require 'minitest/autorun'
require 'minitest/pride'

require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
    require "pry"; binding.pry
  end

  def test_it_returns_all_items
    skip
  end


end
