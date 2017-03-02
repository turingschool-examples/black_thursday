require './test/test_helper'

class CustomerTest < Minitest::Test

attr_reader :customer, :se

  def setup
    @se = SalesEngine.from_csv({
        :merchants    => "./data/merchants.csv",
        :items        => "./data/items.csv",
        :invoices     => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions => "./data/transactions.csv",
        :customers    => "./data/customers.csv"
        })
    @customer = Customer.new({ id:"1",
                               first_name: "Joey",
                               last_name: "Ondricka",
                               created_at: "2012-03-27 14:54:09 UTC",
                               updated_at: "2012-03-27 14:54:09 UTC"})
  end

  def test_it_has_id
    assert_equal 1, customer.id
  end

  def test_it_has_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_created_time
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_updated_time
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  end

  def test_invoices
    assert_instance_of Array, se.customers.customers.first.invoices
    assert_instance_of Invoice, se.customers.customers.first.invoices.first
    assert_equal 8, se.customers.customers.first.invoices.count
  end

  def test_merchants
    assert_equal 1, se.customers.customers.first.merchants.count 
  end
end
