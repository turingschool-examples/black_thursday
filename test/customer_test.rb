# frozen_string_literal: true

require './test/test_helper'
require './lib/customer'
require './lib/sales_engine'

# invoice test
class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new({
      :id          => 6,
      :first_name  => 'Mike',
      :last_name   => 'Dao',
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
    }, 'parent')
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_attributes
    assert_equal 6, @c.id
    assert_equal 'Mike', @c.first_name
    assert_equal 'Dao', @c.last_name
  end
end
