require 'minitest/autorun'
require 'minitest/pride'
require '../lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({:id => 12334105, :name => "Turing School", :created_at => "2016-02-29", :updated_at => "2016-03-01" })
  end

  def test_merchant_can_be_instantiated
    m = @merchant
    assert m
    assert_equal Merchant, m.class
  end

  def test_merchant_id_can_be_identified
    m = @merchant
    assert_equal 12334105, m.id
  end

  def test_merchant_name_can_be_identified
    m = @merchant
    assert_equal "Turing School", m.name
  end

  def test_merchant_object_can_be_inspected
    m = @merchant
    assert_equal "id: 12334105,\nname: Turing School,\ncreated_at: 2016-02-29,\nupdated_at: 2016-03-01", m.inspect
  end
end
