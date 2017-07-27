require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @merchant = @se.merchants.find_by_id(12334105)
    @merch = Merchant.new({:id => 5, :name => "Turing School"}, @se.merchants)

  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_an_id
    assert_equal 5, @merch.id
  end

  def test_items_returns_array_of_items_objects
    assert_instance_of Array, @merchant.items
    assert_instance_of Item, @merchant.items[0]
    assert_equal 1, @merchant.items.count
  end

  def test_invoices_returns_array_of_invoices_by_merchant
    assert_equal 3, @merchant.invoices.count
    assert_instance_of Invoice, @merchant.invoices[0]
  end



end
