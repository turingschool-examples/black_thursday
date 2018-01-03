require './test/test_helper'
require './lib/item_repo'
require './lib/sales_engine'
require './lib/merchant_repo'

class ItemRepoTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @items = @sales_engine.item_repo
  end

  def test_repo_finds_all_items
    assert_equal 40, @items.all.count
  end

  def test_items_order
    assert_equal 1, @items.first.id
  end

end
