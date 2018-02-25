require './test/test_helper'
require './lib/customer'

# test for customer class
class CustomerTest < Minitest::Test
  def setup
    merch_1   = mock
    merch_2   = mock
    cust_repo = stub(merchants: [merch_1, merch_2])
    @customer = Customer.new({
            id: '6',
    first_name: 'Joan',
     last_name: 'Clarke',
    created_at: '1969-07-20 20:17:40  0600',
    updated_at: '1970-07-20 20:17:40  0600'},
    cust_repo)
  end

  def test_it_exists_and_has_attributes
    expected  = Time.parse('1969-07-20 20:17:40  0600')
    expected2 = Time.parse('1970-07-20 20:17:40  0600')

    assert_instance_of Customer, @customer
    assert_equal 6, @customer.id
    assert_equal 'Joan', @customer.first_name
    assert_equal 'Clarke', @customer.last_name
    assert_equal expected, @customer.created_at
    assert_equal expected2, @customer.updated_at
  end

  def test_different_attributes
    cust_repo = mock
    customer  = Customer.new({
      id: '925235',
      first_name: 'Happy',
      last_name: 'Loman',
      created_at: '1982-07-20 20:17:40  0600',
      updated_at: '1990-07-20 20:17:40  0600'},
      cust_repo)
    expected  = Time.parse('1982-07-20 20:17:40  0600')
    expected2 = Time.parse('1990-07-20 20:17:40  0600')

    assert_equal 925235, customer.id
    assert_equal 'Happy', customer.first_name
    assert_equal 'Loman', customer.last_name
    assert_equal expected, customer.created_at
    assert_equal expected2, customer.updated_at
  end

  def test_it_asks_parent_for_merchants
    assert_instance_of Mocha::Mock, @customer.merchants[0]
  end
end
