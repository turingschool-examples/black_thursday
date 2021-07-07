require './test/test_helper.rb'
require './lib/customer.rb'

class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new(
      id: 12000,
      first_name: 'Jimothy',
      last_name: 'Baggins',
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_has_attributes
    assert_equal 12000, @c.id
    assert_equal 'Jimothy', @c.first_name
    assert_equal 'Baggins', @c.last_name
    assert_equal Time.now.to_s, @c.created_at.to_s
    assert_equal Time.now.to_s, @c.updated_at.to_s
  end
end
