require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test

  def test_it_exist
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    assert_instance_of CustomerRepo, cr
  end

  def test_it_returns_all_customers_in_an_array
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    assert_equal "Joey", cr.all.first.first_name
    assert_instance_of Array, cr.all
    assert_equal 8, cr.all.count
    assert_equal "Ondricka", cr.all.first.last_name
  end

  def test_it_can_find_a_customer_by_id
    cr = CustomerRepo.new("./test/fixtures/customers.csv")
    actual = cr.find_by_id(5)
    assert_equal "Sylvester", actual.first_name
    assert_equal 5, actual.id
    # assert_instance_of CustomerRepo, actual
    #why does this break everything 
  end


end
