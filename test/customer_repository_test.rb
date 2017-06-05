require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new("./test/data/customers_truncated.csv", self)
  end

  def test_customer_repo_instantiates
    assert_equal CustomerRepository, @cr.class
  end

  def test_customer_repo_opens_csv_into_array
    assert_equal Array, @cr.all_customer_data.class
  end

  def test_it_returns_customer_instance
    assert_equal Customer, @cr.all[2].class
  end

  def test_it_can_find_by_id
    actual = @cr.find_by_id(6)
    expected = @cr.all[5]

    assert_equal expected, actual
  end

  def test_it_can_return_matches_from_partial_first_names
    actual = @cr.find_all_by_first_name("joe")
    expected = [@cr.all[0]]

    assert_equal expected, actual
  end

  def test_it_can_return_matches_from_partial_last_names
    actual = @cr.find_all_by_last_name("pe")
    expected = [@cr.all[14], @cr.all[15], @cr.all[31]]

    assert_equal expected, actual
  end
end
