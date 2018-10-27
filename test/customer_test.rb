require './test/test_helper'

class CustomerTest < Minitest::Test

  def setup
    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_has_a_name
    assert_equal "Joan", @c.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @c.last_name
  end

  def test_it_is_created_at
    assert_instance_of Time, @c.created_at
  end






end
