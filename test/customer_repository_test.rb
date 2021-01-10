require 'simplecov'
SimpleCov.start

require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @sample_data = './test/fixtures/sample_customers.csv'
  end

  def test_class_exists
    customer_repo = CustomerRepository.new(@sample_data, 'engine')

    assert_instance_of CustomerRepository, customer_repo
  end

  def test_all
    customer_repo = CustomerRepository.new(@sample_data, 'engine')

    assert_equal 6, customer_repo.all.count
  end

  def test_can_find_all_by_first_name
    customer_repo = CustomerRepository.new(@sample_data, 'engine')
    assert_equal [customer_repo.customers[2]], customer_repo.find_all_by_first_name('Mariah')
  end

  def test_can_find_all_by_last_name
    customer_repo = CustomerRepository.new(@sample_data, 'engine')

    assert_equal [customer_repo.customers[3]], customer_repo.find_all_by_last_name('Braun')
  end

  def test_it_can_create
    customer_repo = CustomerRepository.new(@sample_data, 'engine')
    attributes = {
                  :id         => 7,
                  :first_name => 'First',
                  :last_name  => 'Last',
                  :created_at => Time.now,
                  :updated_at => Time.now,
                  }

    customer_repo.create(attributes)
    assert_equal 'First', customer_repo.find_by_id(7).first_name
    assert_equal 7, customer_repo.find_by_id(7).id
  end

  def test_it_can_update
    customer_repo = CustomerRepository.new(@sample_data, 'engine')
    original_names = customer_repo.find_by_id(1).updated_at

    attributes = {
                  :first_name => 'Primero',
                  :last_name => 'Segundo'
                  }

    customer_repo.update(1, attributes)

    assert_equal 'Primero', customer_repo.find_by_id(1).first_name
    assert_equal 'Segundo', customer_repo.find_by_id(1).last_name
    assert original_names < customer_repo.find_by_id(1).updated_at
  end

  def test_it_can_delete
    customer_repo = CustomerRepository.new(@sample_data, 'engine')

    customer_repo.delete(1)

    assert_nil customer_repo.find_by_id(1)
  end
end
