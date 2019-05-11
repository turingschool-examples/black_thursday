# frozen_string_literal: true

require 'timecop'
require './test/test_helper'
require './lib/customer'
require './lib/sales_engine'

# customer test
class CustomerTest < Minitest::Test
  def setup
    Timecop.freeze

    @c = Customer.new({
      id:         6,
      first_name: 'Mike',
      last_name:  'Dao',
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
    }, 'parent')
  end

  def teardown
    Timecop.return
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_attributes
    assert_equal 6, @c.id
    assert_equal 'Mike', @c.first_name
    assert_equal 'Dao', @c.last_name
    assert_equal Time.now.to_s, @c.created_at.to_s
    assert_equal Time.now.to_s, @c.updated_at.to_s
  end

  def test_change_attributes
    assert_equal 'Mike', @c.first_name
    assert_equal 'Dao', @c.last_name

    @c.change_first_name('Matt')
    @c.change_last_name('Bricker')

    assert_equal 'Matt', @c.first_name
    assert_equal 'Bricker', @c.last_name
  end
end
