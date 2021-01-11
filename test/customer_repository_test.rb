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
  end


  def test_it_finds_by_id
    assert_equal nil, @repository.find_by_id(1001)
    assert_equal "Logan", @repository.find_by_id(11).first_name
  end

end
