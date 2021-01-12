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
    assert_equal "27/03/2012", @repository.all[0].updated_at
    assert_equal "27/03/2012", @repository.all[0].created_at
    assert_equal @engine, @repository.engine
  end

  def test_it_finds_by_id
    assert_equal nil, @repository.find_by_id(1001)
    assert_equal "Logan", @repository.find_by_id(11).first_name
  end

  def test_find_all_by_name
    assert_equal 5, @repository.find_all_with_name("first name", "joe").length
    assert_equal [], @repository.find_all_with_name("first name", "little lord fauntleroy")
    assert_equal 2, @repository.find_all_with_name("last name", "toy").length
    assert_equal Customer, @repository.find_all_with_name("last name", "toy")[0].class
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
  #
  def test_it_can_update_customer
    attributes = {first_name: "Charles",
                  last_name: "Vera"}

    @repository.update(3, attributes)

  end

  def test_it_can_delete_customer
    @repository.delete(1000)
    assert_nil @repository.find_by_id(1000)
  end
end
