require_relative 'test_helper'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepo.new("./data/customer_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of CustomerRepo, cr
  end

  def test_returns_all_merchants
    assert_equal 101, cr.all.count
  end

  def test_it_can_find_by_id
    assert_equal "Mariah", cr.find_by_id(3).first_name
  end

  def test_returns_nil_for_bad_id
    assert_nil cr.find_by_id(00)
  end

  def test_it_returns_all_matching_first_names
    assert_equal 1, cr.find_all_by_first_name("Ron").count 
  end
end
