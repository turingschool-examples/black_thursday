require_relative 'test_helper'
require './lib/customer'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @cr = CustomerRepository.new('test/fixtures/customers_truncated_10.csv')
  end

  def test_customer_repository_class_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_customer_repository_has_parent_defaulted_to_nil
    assert_nil @cr.parent
  end

  def test_customer_repository_starts_with_an_empty_array_called_all
    assert_equal 10, @cr.all.count
  end

  def test_from_csv_shovels_customer_instances_according_to_csv_file_rows
    assert_equal 10, @cr.all.count
    assert_instance_of Customer, @cr.all[0]
    assert_equal "Cecelia", @cr.all[1].first_name
  end

  def test_find_by_id_returns_instance_of_customer_according_to_given_id_or_returns_nil_if_no_matching_id
    actual = @cr.find_by_id('2')

    assert_equal @cr.all[1], actual
    assert_nil = @cr.find_by_id('2312312')
  end

  def test_find_all_by_first_name_returns_array_of_all_customers_with_given_first_name
    actual = @cr.find_all_by_first_name("Joey")
    expected = [@cr.all[0], @cr.all[7]]

    assert_equal expected, actual
  end

  def test_find_all_by_last_name_returns_array_of_all_customers_with_given_last_name
    actual = @cr.find_all_by_last_name("Toy")
    expected = [@cr.all[2], @cr.all[9]]

    assert_equal expected, actual
  end

end
