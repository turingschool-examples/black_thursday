require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @file_path = './test/data/customers_test.csv'
  end

  def test_if_class_creates
    cr = CustomerRepository.new(@file_path)

    assert_instance_of CustomerRepository, cr
  end

  def test_if_populates_repo_with_all
    cr = CustomerRepository.new(@file_path)

    assert_equal 10, cr.all.length
  end

  def test_if_find_by_id_works
    cr = CustomerRepository.new(@file_path)

    actual_1 = cr.find_by_id(1)
    actual_2 = cr.find_by_id(25)

    assert_equal cr.all[0], actual_1
    assert_nil actual_2
  end

  def test_if_find_all_by_first_name_works
    cr = CustomerRepository.new(@file_path)

    actual_1 = cr.find_all_by_first_name("Joey")
    actual_2 = cr.find_all_by_first_name("Loki")

    assert_equal [cr.all[0]], actual_1
    assert_equal [], actual_2
  end

  def test_if_find_all_by_last_name_works
    cr = CustomerRepository.new(@file_path)

    actual_1 = cr.find_all_by_last_name("Ondricka")
    actual_2 = cr.find_all_by_last_name("Monster Monkey")

    assert_equal [cr.all[0]], actual_1
    assert_equal [], actual_2
  end

end
