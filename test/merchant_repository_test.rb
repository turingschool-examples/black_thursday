require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).merchants
  end

  def test_merchant_repo_exists
    assert_instance_of MerchantRepository, setup
  end

  def test_it_pulls_csv_info_from_merchants_fixture
    assert_equal 7, setup.all.count
  end

  def test_it_returns_array_of_all_merchants
    assert_equal 7, setup.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Merchant, setup.find_by_id(12334113)
    assert_equal 12334113, setup.find_by_id(12334113).id
  end

  def test_it_can_find_by_name
    merch_name = setup.find_by_name("Candisart")
    assert_equal "Candisart", merch_name.name
  end

  def test_it_can_find_all_by_fragment_of_name
    merch_name = setup.find_all_by_name("candi")
    assert_equal 1, merch_name.count
  end
end
