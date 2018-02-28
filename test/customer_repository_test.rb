require_relative 'test_helper'
require_relative '../lib/customer_repository'

# This is the tests for the customer repo.
class CustomerRepositoryTest < Minitest::Test
  def setup
    customer_csv = './test/fixtures/customer_list_truncated.csv'
    parent = 'parent'
    @cr = CustomerRepository.new(customer_csv, parent)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
    assert_equal 'parent', @cr.parent
  end

  def test_customer_csv_parsed
    assert_equal 21, @cr.customers.length
    assert_equal 1, @cr.customers.first.id
  end

  def test_all_customers
    assert_equal 21, @cr.all.length
    assert @cr.all[3].is_a?(Customer)
    assert @cr.all[0].last_name.include?('Ondricka')
  end

  def test_find_by_id
    assert_nil @cr.find_by_id(111)
    assert_equal 'Considine', @cr.find_by_id(8).last_name
  end

  def test_find_all_by_first_name
    assert_equal [], @cr.find_all_by_first_name('Adam')
    assert_equal 8, @cr.find_all_by_first_name('Loyal').first.id
    assert_equal 8, @cr.find_all_by_first_name('oya').first.id
  end

  def test_find_all_by_last_name
    assert_equal [], @cr.find_all_by_last_name('Adam')
    assert_equal 2, @cr.find_all_by_last_name('si').first.id
    assert_equal 3, @cr.find_all_by_last_name('si').length
    assert_equal 8, @cr.find_all_by_last_name('Considine').first.id
  end

  def test_inspect
    assert_equal '#<CustomerRepository 21 rows>', @cr.inspect
  end
end
