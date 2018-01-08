require_relative "test_helper"
require_relative "../lib/merchant"
require_relative "../lib/sales_engine"

class MerchantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new({id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, parent = nil)

    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, parent = nil)

    assert_equal 12334105, m.id
    assert_equal "Shopin1901", m.name
    assert_instance_of Time, m.created_at
    assert_instance_of Time, m.updated_at
    assert_nil m.merchant_repo
  end

  def test_items_returns_all_items_of_given_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")

    assert_instance_of Array, mr.merchants.first.items
    assert_instance_of Item, mr.merchants.first.items.first
    assert_equal 3, mr.merchants.first.items.count
  end

  def test_invoices_returns_invoices_for_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")
    m = mr.merchants.first

    assert_instance_of Merchant, m
    assert_instance_of Array, m.invoices
    assert_equal 10, m.invoices.count
    m.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 12334105, invoice.merchant_id
    end

  end

  def test_invoices_returns_invoices_for_customers
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    mr = MerchantRepo.new(se, "./data/merchants.csv")
    m = mr.merchants.first

    assert_instance_of Merchant, m
    assert_instance_of Array, m.customers
    assert_equal 10, m.customers.count
    assert_equal "Casimer", m.customers.first.first_name
    assert_equal "Hettinger", m.customers.first.last_name
    assert_equal 14, m.customers.first.id
    m.customers.each do |customer|
    assert_instance_of Customer, m.customers.first
    end
  end


end
