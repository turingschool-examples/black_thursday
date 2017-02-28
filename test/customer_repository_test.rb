require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository.rb'
require './lib/sales_engine'
require 'simplecov'
require './lib/csv_parser.rb'
SimpleCov.start

class TransactionRepositoryTest < Minitest::Test
  include CsvParser

  def test_it_exists
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data)

   assert_instance_of CustomerRepository, cr
  end

  def test_all_method
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data)

    assert_instance_of Array, cr.all
    assert_instance_of Customer, cr.all.first
    assert_equal 3, cr.all.length
  end

  def test_find_by_id
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data)

    assert_instance_of Customer, cr.find_by_id(1)
    assert_nil cr.find_by_id(4)
  end

  def test_find_all_by_first_name
    data = open_file("./test/fixtures/customer_100.csv")
    cr = CustomerRepository.new(data)

    assert_equal "Sophia", cr.find_all_by_first_name("phi").first.first_name
    assert_instance_of Customer, cr.find_all_by_first_name("phi").first
    assert_equal [], cr.find_all_by_first_name("xxxzxy")
  end

  def test_find_all_by_last_name
    data = open_file("./test/fixtures/customer_100.csv")
    cr = CustomerRepository.new(data)

    assert_equal "Kunze", cr.find_all_by_last_name("unz").first.last_name
    assert_instance_of Customer, cr.find_all_by_last_name("unz").first
    assert_equal [], cr.find_all_by_last_name("xzxy")
  end
end