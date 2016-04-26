require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :se, :customers, :customer
  def setup
    @se = SalesEngine.from_csv({
      :customers => "./data/small_customers.csv",})
    @customers = @se.customers
    @customer = @customers.all[0]
  end

  # def test_can_return_id
  #   assert_equal 1, customer.id
  # end
  #
  # def test_can_return_first_name
  #   skip
  #   assert_equal "Kerry", customer.first_name
  # end
  #
  # def test_can_return_last_name
  #   skip
  #   assert_equal "Sheldon", customer.last_name
  # end
  #
  # def test_we_can_time_created_at
  #     assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  # end
  #
  # def test_we_can_time_updated_at
  #   assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  # end

end
