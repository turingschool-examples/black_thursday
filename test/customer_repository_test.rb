require_relative './test_helper'
require 'mocha/minitest'
require 'csv'
require 'bigdecimal'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @engine = mock
    @repository = CustomerRepository.new("./data/customers.csv", @engine)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repository
  end

  def test_it_has_attributes
    assert_equal 1000, @repository.all.length
    assert_equal 1, @repository.all[0].id
    assert_equal "Joey", @repository.all[0].first_name
    assert_equal "Ondricka", @repository.all[0].last_name
    assert_equal @engine, @repository.engine
  end

  def test_it_finds_by_id
    assert_nil @repository.find_by_id(1001)
    assert_equal "Joey", @repository.find_by_id(1).first_name
  end

  def test_find_all_by_first_name
    assert_equal 5, @repository.find_all_by_first_name("joe").length
    assert_equal [], @repository.find_all_by_first_name("little lord fauntleroy")
  end

  def test_find_all_by_last_name
    assert_equal 2, @repository.find_all_by_last_name("toy").length
    assert_equal [], @repository.find_all_by_last_name("little lord fauntleroy")
  end

  def test_new_highest_id
    assert_equal 1001, @repository.new_highest_id
  end

  def test_it_can_create
    @repository.create(:first_name => "Jaqob",
                       :last_name => "Hilario",
                       :created_at => Time.now,
                       :updated_at => Time.now)
    assert_equal "Jaqob", @repository.all[-1].first_name
  end

  def test_it_can_update_customer
    original_time = @repository.find_by_id(3).updated_at
    attributes = {first_name: "Charles",
                  last_name: "Vera"}

    assert_equal "Mariah", @repository.all[2].first_name
    assert_equal "Toy", @repository.all[2].last_name

    @repository.update(3, attributes)

    assert_equal "Charles", @repository.all[2].first_name
    assert_equal "Vera", @repository.all[2].last_name
    assert_equal true, @repository.find_by_id(3).updated_at > original_time
  end

  def test_it_can_delete_customer
    @repository.delete(1000)
    assert_nil @repository.find_by_id(1000)
  end

  def test_inspect
    assert_equal "#<CustomerRepository 1000 rows>", @repository.inspect
  end
end
