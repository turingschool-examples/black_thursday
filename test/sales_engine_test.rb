require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })

    @se.items
    @se.transactions
    @se.invoice_items
    @se.customers
    @se.merchants
    @se.invoices
  end

  def test_it_finds_total_merchants
    assert_equal 21, @se.itself.total_merchants
  end

  def test_it_finds_total_items
    assert_equal 60, @se.itself.total_items
  end

  def test_it_can_find_the_items_for_each_merchant
    assert_equal 21, @se.itself.merchant_item_count.count
    assert_equal 2, @se.itself.merchant_item_count[0]
    assert_equal 11, @se.itself.merchant_item_count[4]
  end


end
