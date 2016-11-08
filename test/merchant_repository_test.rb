require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  
  def setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
    @mr = @se.merchants
  end

  def test_it_creates_merchant_objects
    refute @mr.all.empty?
  end

  def test_it_can_locate_merchant_by_id
    result = @mr.find_by_id(12334105)
    assert_equal "Shopin1901", result.name
  end

  def test_it_can_locate_merchant_by_name 
    result = @mr.find_by_name("Shopin1901")
    assert_equal 12334105, result.id
  end

  def test_it_can_locate_all_merchants_with_name_fragment
    result = @mr.find_all_by_name("SHOP")
    assert_equal 12334105, result[0].id
    assert_equal "Shopin1901", result[0].name
  end

  def test_it_can_get_items_by_merchant
    result = @mr.find_all_items_by_merchant(@mr.all[0])
    assert_equal Array, result.class
  end

  def test_it_can_find_all_invoices_by_merchant
    assert_equal 1, @mr.find_all_invoices_by_merchant(12334269).size
  end

  def test_inspect_message
    assert_equal "#<MerchantRepository 99 rows>", @mr.inspect
  end

end