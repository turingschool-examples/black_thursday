require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_has_item_and_merchant_repository
    se = SalesEngine.new("empty")
    mr = se.merchant_repo
    ir = se.item_repo
    assert_equal MerchantRepo, mr.class
    assert_equal ItemRepo, ir.class
  end

  def test_single_line_csv_merchant

    se = SalesEngine.from_csv({
      :merchants => './test/support/single_merchant.csv'
      })
    assert_equal 1, se.merchant_repo.all.count
    assert_equal 12334105, se.merchant_repo.all.first.id
  end

  def test_add_small_merchant_csv
    # se = SalesEngine.new
    se = SalesEngine.from_csv({
      :merchants => './test/support/small_merchant_list.csv'
      })

    assert_equal 9, se.merchant_repo.all.count
  end

  def test_single_line_csv_item
    # se = SalesEngine.new
    se = SalesEngine.from_csv({
      :items => './test/support/single_item.csv'
      })
    assert_equal 1, se.item_repo.all.count
    assert_equal 263395237, se.item_repo.all.first.id
  end

  def test_small_item_csv
    # se = SalesEngine.new
    se = SalesEngine.from_csv({
      :items => './test/support/small_item_list.csv'
      })
    assert_equal 10, se.item_repo.all.count
  end

  def test_item_repo_can_access_sales_engine
    se = SalesEngine.new("empty")
    item_repo = se.item_repo
    assert_equal se, item_repo.sales_engine
  end

  def test_merchant_repo_can_access_sales_engine
    se = SalesEngine.new("empty")
    merchant_repo = se.merchant_repo
    assert_equal se, merchant_repo.sales_engine
  end

  def test_merchant_can_find_items
    se = SalesEngine.new("empty")
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
    item_3_details = {
      :id => 30,
      :name => "A thing you don't want",
      :merchant_id => 31
    }
    items = [item_1_details, item_2_details, item_3_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add_item(item)
    end
    merchants.each do |merchant|
      mr.add_merchant(merchant)
    end
    merchant = mr.find_by_id(21)
    item_1 = ir.find_by_name("A thing that you want")
    item_2 = ir.find_by_name("A thing you sorta want")
    assert_equal [item_1, item_2], merchant.items
  end

  def test_item_can_find_merchant
    se = SalesEngine.new("empty")
    ir = se.item_repo
    mr = se.merchant_repo
    item_1_details = {
      :id => 20,
      :name => "A thing that you want",
      :merchant_id => 21
    }
    item_2_details = {
      :id =>22,
      :name => "A thing you sorta want",
      :merchant_id => 21
    }
    item_3_details = {
      :id => 30,
      :name => "A thing you don't want",
      :merchant_id => 31
    }
    items = [item_1_details, item_2_details, item_3_details]
    merchant_1_details = {
      :name => "The awesome store",
      :id   => 21
    }
    merchant_2_details = {
      :name => "Trump Store of Fail",
      :id   => 666
    }
    merchants = [merchant_1_details, merchant_2_details]

    items.each do |item|
      ir.add_item(item)
    end
    merchants.each do |merchant|
      mr.add_merchant(merchant)
    end
    expected_merchant = mr.find_by_id(21)
    item = ir.find_all_by_merchant_id(21).first
    assert_equal expected_merchant, item.merchant
  end

end
