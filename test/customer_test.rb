require './lib/sales_engine.rb'

class CustomerTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/mock.csv",
    :invoice_items => "./data/mock.csv",
    :transactions => "./data/mock.csv",
    :customers => "./data/customers.csv"
    })

    @cr = se.customers
    @customer = @cr.find_by_id(500)
  end

  def test_it_can_return_its_id
    assert_equal 500, @customer.id
  end

  def test_it_can_return_customers_first_name
    assert_equal 'Hailey', @customer.first_name
  end

  def test_it_can_return_customers_last_name
    assert_equal 'Veum', @customer.last_name
  end

  def test_it_can_return_created_at
    assert_equal Time.parse('2012-03-27 14:56:08 UTC'), @customer.created_at
  end

  def test_it_can_return_updated_at
    assert_equal Time.parse('2012-03-27 14:56:08 UTC'), @customer.updated_at
  end
end
