
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryClassTest < Minitest::Test

  def setup
    sales_engine = "sales engine"
    @customers = CustomerRepository.new(sales_engine)

    @customers.repository << Customer.new(sales_engine, {:id => "234",
      :first_name => "Joe",
      :last_name => "Blow",
      :unit_price => "13635",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

    @customers.repository << Customer.new(sales_engine, {:id => "523",
      :first_name => "John",
      :last_name => "Doe",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

  end

  def test_can_get_all_customers_in_repository
    assert_equal 2, @customers.all.count
  end

  def test_can_find_a_customer_by_its_id
    assert_equal "Joe", @customers.find_by_id(234).first_name
    assert_equal "John", @customers.find_by_id(523).first_name
  end

  def test_can_find_all_customer_by_first_name_fragment
    assert_equal ["Joe"], @customers.find_all_by_first_name("oe").map {|customer| customer.first_name}
    assert_equal ["Joe", "John"], @customers.find_all_by_first_name("j").map {|customer| customer.first_name}
  end

  def test_can_find_all_customers_by_last_name_fragment
    assert_equal ["Joe"], @customers.find_all_by_last_name("bl").map {|customer| customer.first_name}
    assert_equal ["Joe", "John"], @customers.find_all_by_last_name("o").map {|customer| customer.first_name}
  end

end
