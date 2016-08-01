require './test/test_helper'
require './lib/customer'
require 'csv'

class CustomerTest < Minitest::Test
  attr_reader :customer_rows, :customer_1

  def setup
    fixture = CSV.open('./test/fixtures/customers_fixture.csv',
                          headers:true,
                          header_converters: :symbol)
    @customer_rows = fixture.to_a
    @customer_1 = Customer.new(customer_rows[0])
  end

  def test_has_fixnum_id
    assert_equal 1, customer_1.id
  end

  def test_has_string_names
    assert_equal 'Joey', customer_1.first_name
    assert_equal 'Ondricka', customer_1.last_name
  end

  def test_has_time_objects
    assert_instance_of Time, customer_1.created_at
    assert_instance_of Time, customer_1.updated_at
  end

  def test_method_merchants_queries_parent
    mock_cr = Minitest::Mock.new
    customer = Customer.new({id: 1}, mock_cr)
    mock_cr.expect(:find_all_merchants_by_id, nil, [1])
    customer.merchants
    assert mock_cr.verify
  end
end
