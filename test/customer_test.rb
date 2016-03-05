require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :merchants => './fixtures/merchants_fixtures.csv',
      :items     => './fixtures/items_fixtures.csv',
      :invoices  => './fixtures/invoices_fixtures.csv',
      :customers => './fixtures/customers_fixtures.csv'
      })
    cr = se.customers
    @c = cr.find_by_id(1)
  end

  def test_id_returns_the_id_as_integer
    assert_equal 1, @c.id
  end

  def test_first_name_returns_first_name
    assert_equal "Joey", @c.first_name
  end

  def test_last_name_returns_last_name
    assert_equal "Ondricka", @c.last_name
  end

  def test_created_at_returns_time_object
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @c.created_at
  end

  def test_updated_at_returns_time_object
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @c.updated_at
  end

  def test_merchants_returns_associated_merchants
    assert_equal 4, @c.merchants.count
    assert_equal "NatureDots", @c.merchants[0].name
    assert_equal "MiniatureBikez", @c.merchants[3].name
  end

end
