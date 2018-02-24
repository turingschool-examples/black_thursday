require './test/test_helper'
require './lib/customer_repository'

# test for customer repository class
class CustomerRepositoryTest < Minitest::Test
  def setup
    file_path  = './data/sample_data/customers.csv'
    @cust_repo = CustomerRepository.new(file_path)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cust_repo
  end

  def test_customer_repository_adds_self_to_customer
    assert_equal @cust_repo, @cust_repo.all.first.parent
  end

  def test_all
    assert_instance_of Array, @cust_repo.all
    assert_instance_of Customer, @cust_repo.all.first
    assert_equal 1, @cust_repo.all.first.id
    assert_equal 'Braun', @cust_repo.all.last.last_name
  end

  def test_find_by_id
    assert_nil @cust_repo.find_by_id(8)
    assert_instance_of Customer, @cust_repo.find_by_id(3)
    assert_equal 'Joey', @cust_repo.find_by_id(1).first_name
  end

  def test_find_by_first_name
    actual = @cust_repo.find_by_first_name('IA')

    assert_equal [], @cust_repo.find_by_first_name('SOUOU')
    assert_equal 2, actual.length
    assert_equal 'Cecelia', actual[0].first_name
  end

  def test_find_by_last_name
    actual = @cust_repo.find_by_last_name('I')

    assert_equal [], @cust_repo.find_by_last_name('SOUOU')
    assert_equal 2, actual.length
    assert_equal 'Joey', actual[0].first_name
  end

  def test_inspect
    expected = '#<CustomerRepository 4 rows>'
    assert_equal expected, @cust_repo.inspect
  end
end
