
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

# Test class Merchant
class MerchantTest < Minitest::Test

  def setup
    @time = Time.now
    @merch = Merchant.new(
                          id:   3,
                          name: "Bill's Pencil Company"
                          )
  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_attributes
    assert_equal 3, @merch.id
    assert_equal "Bill's Pencil Company", @merch.name
  end

  # def test_it_returns_total_revenue
  #
  # end
end
