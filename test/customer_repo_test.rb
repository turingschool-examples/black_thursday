require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repo'
require 'pry'

class CustomerRepoTest < MiniTest::Test

  def setup
    @cr = CustomerRepo.new("./data/customers.csv")
  end

  def test_it_exist
    assert_instance_of CustomerRepo, @cr
  end

  def test_it_can_find_by_id
    assert_equal "Sylvester", @cr.find_by_id(5).first_name
  end

  def test_returns_nil_for_bad_id
    assert_nil @cr.find_by_id(0)
  end

  def test_it_returns_all_matching_first_names
    assert_equal 1, @cr.find_all_by_first_name("Joey").count
  end

  def test_returns_empty_array_for_first_name
    assert_equal [], @cr.find_all_by_first_name("Bz")
  end

  def test_it_can_find_all_by_last_name
    assert_equal 3, @cr.find_all_by_last_name("Osinski").count
  end

  def test_it_returns_empty_array_for_no_last_name
    assert_equal [], @cr.find_all_by_last_name("Zrd")
  end

end
