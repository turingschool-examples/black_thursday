require_relative 'test_helper.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'

class MerchantTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
    @merchant = Merchant.new({:id => '5', :name => 'Turing School'}, @sales_engine.merchants)
  end

  def test_merchant_initializes
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_id_and_name
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
  end

  def test_merchant_items_returns_items_array
    merchant = @sales_engine.merchants.find_by_id(12334141)
    merchant.items

    assert_equal 1, merchant.items.count
    assert_equal "510+ RealPush Icon Set", merchant.items[0].name
  end

  def test_merchant_invoices_returns_invoices_array
    merchant = @sales_engine.merchants.find_by_id(12335955)
    merchant.invoices

    merchant_no_invoice = @sales_engine.merchants.find_by_id(12334141)
    merchant_no_invoice.invoices

    assert_equal 2, merchant.invoices.length
    assert merchant_no_invoice.invoices.empty?
  end

  def test_merchant_customers_returns_customers_array
    merchant = @sales_engine.merchants.find_by_id(12335955)
    merchant.customers

    assert_equal 2, merchant.customers.length
    assert_instance_of Customer, merchant.customers[0]
  end
end
