require_relative 'test_helper.rb'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative 'sales_engine_methods'

class MerchantTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :se

  def setup
    create_sales_engine
  end

  def test_it_exists
    m = Merchant.new({:id => 5}, "engine")

    assert_instance_of Merchant, m
  end

  def test_it_knows_name
    m = Merchant.new({:name => "Turing"}, "engine")
    assert_equal "Turing", m.name
  end

  def test_it_can_find_all_instances_of_item_that_match_merch_id
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/temp_merchants.csv",
        :items     => "./test/fixtures/temp_items.csv",
        :invoices => "./test/fixtures/invoices_truncated.csv"
        })
    merchant = se.merchants.find_by_id(12334185)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items.first
    assert_equal "Disney scrabble frames", merchant.items.last.name
  end

  def test_it_can_find_all_instances_of_invoice_that_match_merch_id
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/merchants_for_invoice_sales_analysis.csv",
        :items => "./test/fixtures/temp_items.csv",
        :invoices     => "./test/fixtures/invoices_truncated.csv"
        })
    merchant = se.merchants.find_by_id(12334753)

    assert_instance_of Array, merchant.invoices
    assert_instance_of Invoice, merchant.invoices.first
    assert_equal 777, merchant.invoices.last.id
  end

  def test_it_can_find_customers_by_merchant_id
    merchant = se.merchants.find_by_id(12334185)

    assert_instance_of Array, merchant.customers
    assert_instance_of Customer , merchant.customers.first
    assert_equal "Joey", merchant.customers.first.first_name
  end

end
