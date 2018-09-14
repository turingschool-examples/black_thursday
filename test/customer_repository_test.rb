
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require './lib/customer'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/customers.csv'
    @repo = CustomerRepository.new(@path)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repo
  end 

  def test_it_gets_invoice_items
    invoice_items = @repo.all.first(100)
    assert_instance_of Array, @repo.all
    assert_equal 100, invoice_items.count
    assert_equal 100, invoice_items.uniq.count
  end
  
  
  def test_it_can_find_all
    assert_equal 1000, @repo.all.count
  end
end