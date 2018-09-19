require_relative 'test_helper'

require './lib/merchant'


class MerchantTest < Minitest::Test

  def setup
    # CSV: 12334105,Shopin1901,2010-12-10,2011-12-04
    input = {:id => "12334105", :name => "Shopin1901"}
    @merchant = Merchant.new(input)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 12334105, @merchant.id
    assert_equal "Shopin1901", @merchant.name
  end

  def test_it_can_make_an_update
    now = Time.now
    hash = {id: "NOPE", created_at: "NOPE",
            name: "YES",  updated_at: now }
    @merchant.make_update(hash)
    # --- denied ---
    refute_equal "NOPE", @merchant.id
    refute_equal "NOPE", @merchant.created_at
    # --- allowed ---
    assert_equal "YES", @merchant.name
    assert_equal now.to_s, @merchant.updated_at.to_s
  end


end
