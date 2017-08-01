require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine.rb'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    assert_instance_of Merchant, merch
  end

  def test_merchant_has_name
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    name = merch.name

    assert_equal "Pillowtalkdartmoor", name
  end

  def test_merchant_has_id
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    id = merch.id

    assert_equal 12337011, id
  end

  def test_merchant_has_created_at_date
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    create_date = merch.created_at

    assert_equal "2004-10-06", create_date
  end

  def test_merchant_has_updated_at_date
    merch = Merchant.new({:name => "Pillowtalkdartmoor",
                          :id => 12337011,
                          :created_at => "2004-10-06",
                          :updated_at => "2014-12-04"},
                          self)
    update_date = merch.updated_at

    assert_equal "2014-12-04", update_date
  end

  def test_merchant_can_check_for_items
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
    merchants = se.merchants
    merchant = merchants.find_by_id(12335119)
    items = merchant.items

    assert_instance_of Array, items
    assert_instance_of Item, items[0]
    assert_equal 2, items.count
  end

  def test_merchant_can_check_for_invoices
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
    merchants = se.merchants
    merchant = merchants.find_by_id(12335119)
    invoices = merchant.invoices

    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices[0]
    assert_equal 9, invoices.count
  end

  def test_merchant_can_get_customers
    se = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :customers => './data/customers.csv',
      :invoices => './data/invoices.csv'
      })
    merchants = se.merchants
    merchant = merchants.find_by_id(12334194)
    customers = merchant.customers

    assert_instance_of Array, customers
    assert_instance_of Customer, customers[0]
    assert_equal 12, customers.count
  end

  def test_merchant_can_get_revenue
    se = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :merchants => './data/merchants.csv',
      :transactions => './data/transactions.csv',
      :invoice_items => './data/invoice_items.csv'
      })
    merchants = se.merchants
    merchant = merchants.find_by_id(12334194)
    revenue = merchant.revenue

    assert_instance_of BigDecimal, revenue
    assert_equal 81572.4, revenue.to_f
  end

end
