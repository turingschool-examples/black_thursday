require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  
  include CsvParser

  attr_reader :parent

  def setup
    @parent = SalesEngine.from_csv({:customers => './test/fixtures/customer_three.csv'})
  end

  def test_it_exists
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data, parent)

   assert_instance_of CustomerRepository, cr
  end

  def test_all_method
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data, parent)

    assert_instance_of Array, cr.all
    assert_instance_of Customer, cr.all.first
    assert_equal 3, cr.all.length
  end

  def test_find_by_id
    data = open_file("./test/fixtures/customer_three.csv")
    cr = CustomerRepository.new(data, parent)

    assert_instance_of Customer, cr.find_by_id(1)
    assert_nil cr.find_by_id(4)
  end

  def test_find_all_by_first_name
    data = open_file("./test/fixtures/customer_100.csv")
    cr = CustomerRepository.new(data, parent)

    assert_equal "Sophia", cr.find_all_by_first_name("phi").first.first_name
    assert_instance_of Customer, cr.find_all_by_first_name("phi").first
    assert_equal [], cr.find_all_by_first_name("xxxzxy")
  end

  def test_find_all_by_last_name
    data = open_file("./test/fixtures/customer_100.csv")
    cr = CustomerRepository.new(data, parent)

    assert_equal "Kunze", cr.find_all_by_last_name("unz").first.last_name
    assert_instance_of Customer, cr.find_all_by_last_name("unz").first
    assert_equal [], cr.find_all_by_last_name("xzxy")
  end

  def test_parent_is_instance_of_sales_engine
    se = SalesEngine.from_csv({:customers => './test/fixtures/customer_three.csv'})
    cr = se.customers
    
    assert_instance_of SalesEngine, cr.parent
  end
end