require_relative 'test_helper'
require_relative '../lib/customer_repository'
require 'pry'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :cr

  def setup
    @cr = CustomerRepository.new("./test/data/customers_fixture.csv", self)
  end

  def test_new_instance

    assert_instance_of CustomerRepository, cr
    assert_instance_of Customer, cr.contents[1]
  end

  def test_all
    expected = [ 1, 2, 3, 4, 5, 10, 23, 47, 66, 511 ]
    x = cr.all
    actual = x.map { |i| i.id }

    assert_equal expected, actual
  end

  def test_find_by_id
    x = cr.find_by_id(2)
    actual = x.id

    assert_equal 2, actual
    assert_nil cr.find_by_id(200)
  end

  def test_find_all_by_first_name
    expected = [ 47, 511 ]
    x = cr.find_all_by_first_name("Wayne")
    actual = x.map { |i| i.id }
binding.pry
    assert_equal expected, actual
    assert_equal [], cr.find_all_by_first_name("Ted")
  end

  def test_find_all_by_last_name
    expected = [ 5, 23, 66 ]
    x = cr.find_all_by_last_name("Nader")
    actual = x.map { |i| i.id }

    assert_equal expected, actual
    assert_equal [], cr.find_all_by_last_name("Jones")
  end

end
