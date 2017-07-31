require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_customer_exists
    customer = Customer.new({
      :id => 230, :first_name => "Matilda", :last_name => "Connelly",
      :created_at => "2012-03-27 14:55:06 UTC",
      :updated_at => "2012-03-27 14:55:06 UTC"
      }, self)

    assert_instance_of Customer, customer
  end

end


# id,first_name,last_name,created_at,updated_at
# 230,Matilda,Connelly,2012-03-27 14:55:06 UTC,2012-03-27 14:55:06 UTC
