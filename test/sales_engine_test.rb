require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_has_item_and_merchant_repository
    se = SalesEngine.new
    mr = se.merchant_repo
    ir = se.item_repo
    assert_equal MerchantRepo, mr.class
    assert_equal ItemRepo, ir.class
  end

  def test_single_line_csv_merchant
    se = SalesEngine.new
    se.from_csv({
      :merchants => './test/support/single_merchant.csv'
      })
    assert_equal 1, se.merchant_repo.all.count
    assert_equal 12334105, se.merchant_repo.all.first.id
  end

  def test_add_small_merchant_csv
    se = SalesEngine.new
    se.from_csv({
      :merchants => './test/support/small_merchant_list.csv'
      })

    assert_equal 9, se.merchant_repo.all.count
  end

  def test_single_line_csv_item
    se = SalesEngine.new
    se.from_csv({
      :items => './test/support/single_item.csv'
      })
    assert_equal 1, se.item_repo.all.count
    assert_equal 263395237, se.item_repo.all.first.id
  end

  def test_small_item_csv
    se = SalesEngine.new
    se.from_csv({
      :items => './test/support/small_item_list.csv'
      })
    assert_equal 10, se.item_repo.all.count
  end

  def test_item_repo_can_access_sales_engine
    se = SalesEngine.new
    item_repo = se.item_repo
    assert_equal se, item_repo.sales_engine
  end

  def test_merchant_repo_can_access_sales_engine
    se = SalesEngine.new
    merchant_repo = se.merchant_repo
    assert_equal se, merchant_repo.sales_engine
  end
end
