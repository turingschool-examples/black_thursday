require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test

  def setup
      @c = Customer.new({"id"          => '1',
                         "first_name"  => 'Joan',
                         "last_name"   => "Clarke",
                         "created_at"  => '1993-09-29 11:56:40 UTC',
                         "updated_at"  => '1993-09-29 11:56:40 UTC'
                        })
  end

  def test_if_class_creates

    assert_instance_of Customer, @c
  end

  def test_default_attributes_and_format

    assert_equal 1, @c.id
    assert_equal "Joan", @c.first_name
    assert_equal "Clarke", @c.last_name
    assert @c.created_at
    assert @c.updated_at
  end

end
