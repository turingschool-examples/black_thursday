require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repo'
require 'csv'
require 'pry'

class CustomerRepoTest < Minitest::Test
  attr_reader :file,
              :sales_engine
  def setup
    @file = "./data/customers.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    cr = CustomerRepo.new(file, sales_engine)
    assert_equal CustomerRepo, cr.class
  end

  def test_it_can_display_all_transactions
    cr = CustomerRepo.new(file, sales_engine)
    assert cr.all
  end

  def test_it_can_find_by_id
    cr = CustomerRepo.new(file, sales_engine)
    assert_equal 786, cr.find_by_id(786).id
  end

   def test_it_can_find_by_first_name
    cr = CustomerRepo.new(file, sales_engine)
    assert_equal 978, cr.find_by_first_name("Karl")
  end
  
  def test_it_can_find_by_last_name
   cr = CustomerRepo.new(file, sales_engine)
   assert_equal 672, cr.find_by_last_name("Simonis")
 end
end