require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })
    se.items
    se.transactions
    se.invoice_items
    se.customers
    se.invoices
    se.merchants
  end

  def test_it_exists
    m1 = Merchant.new({:id => 5, :name => "Turing School"}, '')

    assert_instance_of Merchant, m1
  end

  def test_it_has_an_id
    m1 = Merchant.new({:id => 5, :name => "Turing School"}, '')

    assert_equal 5, m1.id
  end

  def test_it_has_a_name
    m1 = Merchant.new({:id => 5, :name => "Turing School"},'')

    assert_equal "Turing School", m1.name
  end

  def test_it_can_connect_to_items
    mr = setup

    merchant1 = mr.find_by_id(12334112)
    merchant1_items = merchant1.items

    merchant2 = mr.find_by_id(12334123)
    merchant2_items = merchant2.items

    assert_equal 1, merchant1_items.count
    assert_equal 11, merchant2_items.count
  end

  def test_merchant_can_return_assigned_items
    mr = setup

    merchant = mr.find_by_id(12334403)

    items = merchant.items

    assert_equal 'Knitted winter snood', items[0].name
    assert_equal 1, items.count
  end

  def test_merchant_can_return_invoices
    mr = setup

    merchant = mr.find_by_id(12334403)

    assert_equal 1, merchant.invoices.count
  end
end
