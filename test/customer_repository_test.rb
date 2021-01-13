require_relative './test_helper'
require 'mocha/minitest'
require 'csv'
require 'bigdecimal'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @engine = mock
    @repository = CustomerRepository.new("./fixture_data/customers_sample.csv", @engine)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repository
  end

  def test_it_has_attributes
    assert_equal 124, @repository.all.length
    assert_equal 11, @repository.all[0].id
    assert_equal "Logan", @repository.all[0].first_name
    assert_equal "Kris", @repository.all[0].last_name
    assert_equal @engine, @repository.engine
  end

  def test_it_finds_by_id
    assert_nil @repository.find_by_id(1001)
    assert_equal "Logan", @repository.find_by_id(11).first_name
  end

  def test_find_all_by_first_name
    assert_equal 1, @repository.find_all_by_first_name("Logan").length
    assert_equal [], @repository.find_all_by_first_name("little lord fauntleroy")
  end

  def test_find_all_by_last_name
    assert_equal 1, @repository.find_all_by_last_name("Kris").length
    assert_equal [], @repository.find_all_by_last_name("little lord fauntleroy")
  end

  def test_new_highest_id
    assert_equal 999, @repository.new_highest_id
  end

  def test_it_can_create
    @repository.create(:first_name => "Jaqob",
                       :last_name => "Hilario",
                       :created_at => Time.now,
                       :updated_at => Time.now)
    assert_equal "Jaqob", @repository.all[-1].first_name
  end

  def test_it_can_update_customer
    original_time = @repository.find_by_id(14).updated_at
    attributes = {first_name: "Charles",
                  last_name: "Vera"}

    assert_equal "Kirstin", @repository.all[2].first_name
    assert_equal "Wehner", @repository.all[2].last_name

    @repository.update(14, attributes)

    assert_equal "Kirstin", @repository.all[2].first_name
    assert_equal "Wehner", @repository.all[2].last_name
    assert_equal true, @repository.find_by_id(14).updated_at > original_time
  end

  def test_it_can_delete_customer
    @repository.delete(1000)
    assert_nil @repository.find_by_id(1000)
  end

  def test_inspect
    assert_equal "#<CustomerRepository 124 rows>", @repository.inspect
  end
end
