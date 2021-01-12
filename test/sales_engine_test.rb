require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'csv'
class SalesEngineTest < Minitest::Test
  def setup
    @merchant_path = './data/merchants.csv'
    @item_path = './data/items.csv'
    @invoice_path = './data/invoices.csv'
    @locations = { items: @item_path,
                  merchants: @merchant_path,
                  invoices: @invoice_path
                }

    @se = SalesEngine.from_csv(@locations)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesEngine, @se
  end

  def test_it_creates_sales_analyst
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of SalesAnalyst, @se.analyst
  end

  def test_merchant_id_list
    assert_equal 475, @se.merchant_id_list.length
  end

  def test_merchant_items_count
    assert_equal 475, @se.merchant_hash_item_count.length
  end

  def test_pass_item_array
    assert_instance_of Array, @se.pass_item_array
    assert_equal 1367, @se.pass_item_array.length
  end

  def test_find_by_merchant_id
    assert_equal "Shopin1901", @se.find_by_merchant_id(12334105).name
  end

  def test_average_item_price
    assert_equal 251.06, @se.average_item_price
  end

  def test_count_items
    assert_instance_of Array, @se.pass_item_array
    assert_equal 1367, @se.count_items
  end

  def test_count_merchants
    assert_instance_of Array, @se.pass_item_array
    assert_equal 475, @se.count_merchants
  end

  def test_find_all_by_merchant_id
    assert_instance_of Array, @se.find_all_by_merchant_id(12_334_141)
    assert_equal 263395237, @se.find_all_by_merchant_id(12_334_141)[0].id
  end

  def test_returns_total_invoices
    assert_equal 4985, @se.total_invoices
  end

  def test_returns_per_merchant_invoice_count_hash
    assert_equal 475, @se.per_merchant_invoice_count_hash.length
  end

  def test_returns_invoices_per_day
    days = { "Monday" =>    696,
             "Tuesday" =>   692,
             "Wednesday" => 741,
             "Thursday" =>  718,
             "Friday" =>    701,
             "Saturday" =>  729,
             "Sunday" =>    708}

    assert_equal days, @se.invoices_per_day
  end

  def test_invoices_per_status
    status = {pending:  1473,
              shipped:  2839,
              returned: 673}

    assert_equal status, @se.invoices_per_status
  end
end
