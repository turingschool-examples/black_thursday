require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'


class CustomerTest < Minitest::Test

  def test_it_is_initialized_corretly
    c = Customer.new({name: "Marty"}, 1)
    assert_instance_of Customer, c
  end

  def setup
    hash = {id: 1,
            first_name: "Mark",
            last_name: "Clarke",
            created_at: "2012-03-27 14:54:10 UTC",
            updated_at: "2012-03-27 14:54:10 UTC"
           }
    @customer = Customer.new(hash, self)
  end

  def test_it_has_id
    assert_equal 1, @customer.id
  end

  def test_it_has_first_name
    assert_equal "Mark", @customer.first_name
  end

  def test_it_has_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_it_has_created_at
    assert_instance_of Time, @customer.created_at
  end

  def test_it_has_updated_at
    assert_instance_of Time, @customer.updated_at
  end




end
