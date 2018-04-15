require_relative 'test_helper'
require './lib/customer_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_exists
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    assert_instance_of CustomerRepository, cr
  end

  def test_it_can_have_path
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    assert_equal './test/fixtures/customers.csv', cr.path
  end

  def test_it_can_load_all_customers_from_csv
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    assert_equal 200, cr.all.count
    assert_equal 1, cr.all.first.id
    assert_equal 'Joey', cr.all.first.first_name
    assert_equal 'Ondricka', cr.all.first.last_name
  end

  def test_it_can_find_by_id
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_by_id(5)

    assert_equal 5, result.id
    assert_equal 'Sylvester', result.first_name
    assert_equal 'Nader', result.last_name
  end

  def test_it_return_nil_for_invalid_id
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_by_id(000000)

    assert_nil result
  end

  def test_it_can_find_all_customers_by_first_name
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_all_by_first_name('Sylves')

    assert_equal 1, result.count
    assert_equal 'Sylvester', result.first.first_name
    assert_equal 'Nader', result.first.last_name
    assert_equal 5, result.first.id
  end
  def test_it_returns_empty_array_for_invalid_first_name
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_all_by_first_name('manoj')

    assert_equal [], result
  end

  def test_it_can_find_all_customers_by_first_name
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_all_by_last_name('Nade')

    assert_equal 3, result.count
    assert_equal 'Sylvester', result.first.first_name
    assert_equal 'Nader', result.first.last_name
    assert_equal 5, result.first.id
  end

  def test_it_returns_empty_array_for_invalid_last_name
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_all_by_last_name('manoj')

    assert_equal [], result
  end

  def test_it_can_create_new_customer_id
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    assert_equal 200, cr.customers.count

    assert_equal 201, cr.create_new_id
  end

  def test_it_can_create_new_customer
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    assert_equal 200, cr.customers.count

    assert_nil cr.find_by_id(201)

    result = cr.create({:first_name => 'tyler',
                        :last_name => 'westlie'
                        })

    result1 = cr.find_by_id(201)

    assert_equal 201, result1.id
    assert_equal 'tyler', result1.first_name
    assert_equal 'westlie', result1.last_name
    # assert_equal '', result1.created_at
    # assert_equal '', result1.updated_at
  end

  def test_it_can_update_customer
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_by_id(5)

    assert_equal 'Sylvester', result.first_name
    assert_equal 'Nader', result.last_name
    assert_equal 5, result.id

    cr.update(5, { :first_name => 'tyler',
                   :last_name => 'westlie'})
    result1 = cr.find_by_id(5)

    assert_equal 'tyler', result.first_name
    assert_equal 'westlie', result.last_name
    assert_equal 5, result.id
  end

  def test_it_can_update_customer_with_supplied_attribute_only
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_by_id(5)

    assert_equal 'Sylvester', result.first_name
    assert_equal 'Nader', result.last_name

    cr.update(5, { :first_name => 'tyler'
                 })

    result1 = cr.find_by_id(5)

    assert_equal 'tyler', result.first_name
    assert_equal 'Nader', result.last_name
    assert_equal 5, result.id
  end

  def test_it_can_delete_customer
    cr = CustomerRepository.new('./test/fixtures/customers.csv', nil)

    result = cr.find_by_id(5)

    refute_nil result

    cr.delete(5)

    assert_nil cr.find_by_id(5)
  end
end
