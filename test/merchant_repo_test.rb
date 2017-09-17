require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    SalesEngine.from_csv(files).merchants
  end

  def test_merchant_exists
    assert_instance_of MerchantRepository, set_up
  end

  def test_all_merchants
    assert_equal 6, set_up.all.count
  end

  def test_find_by_id_nil
    assert_nil set_up.find_by_id(39472)
  end

  def test_find_specific_id
    assert_instance_of Merchant, set_up.find_by_id(12334115)
  end

  def test_find_by_name_nil
    assert_nil set_up.find_by_name("Gerald")
  end

  def test_find_specific_name
    assert_instance_of Merchant, set_up.find_by_name("Shopin1901")
  end

  def test_find_all_by_name
    fragment = "Goboababab"

    assert_equal [], set_up.find_all_by_name(fragment)
  end

  def test_find_all_by_name_specific_name
    fragment = "Shop"

    assert_equal 2, set_up.find_all_by_name(fragment).count
  end

  def test_find_all_by_name_specific_name_again
    fragment = "Candi"

    assert_equal 1, set_up.find_all_by_name(fragment).count
  end
end
