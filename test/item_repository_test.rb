require './test/minitest_helper'
require './lib/item_repository'
require 'CSV'

class MerchantTest<Minitest::Test

  def setup
    @ir = ItemRepository.new('./test/fixtures/items_fixtures.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_item_repo_has_items
    assert_equal 10 , @ir.all.count
    assert_instance_of Array, @ir.all
  end
end
