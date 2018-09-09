require './test/minitest_helper'
require './lib/item_repository'
require 'CSV'

class MerchantTest<Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./test/fixtures/item_fixtures.csv')

    assert_instance_of ItemRepository, ir
  end

  def test_item_repo_has_items
    ir = ItemRepository.new('./test/fixtures/item_fixtures.csv')

    assert_equal 10 , ir.all.count
    assert_instance_of Array, ir.all
  end
end
