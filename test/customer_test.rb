require './test/test_helper'

class CustomerTest < Minitest::Test

  def setup
    @repo = mock
    @data = Customer.new({
       :id => 6,
       :first_name => "Joan",
       :last_name => "Clarke",
       :created_at => Time.parse("2016-01-11 11:51:37 UTC"),
       :updated_at => Time.now
        }, @repo)
   end

  def test_it_exists
    assert_instance_of Customer, @data
  end

  def test_it_has_attributes
    assert_equal 6, @data.id
    assert_equal "Joan", @data.first_name
    assert_equal "Clarke", @data.last_name
    expected = Time.parse("2016-01-11 11:51:37 UTC")
    assert_equal expected, @data.created_at
    assert_instance_of Time, @data.updated_at
  end
end
