require './test/test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = ItemRepo.new("./data/item_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepo, ir
  end

  def test_it_finds_all_items
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_by_id
    expected = "510+ RealPush Icon Set"
    assert_instance_of Item, ir.find_by_id(263395237)
    assert_equal expected, ir.find_by_id(263395237).name
  end
end
