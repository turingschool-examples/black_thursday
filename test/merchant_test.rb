require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    assert Merchant.new({:id =>"12337411"})
  end

  def test_it_has_a_class
    m = Merchant.new({:id =>"12337411"})
    assert_equal Merchant, m.class
  end

  def test_it_has_an_id
    m = Merchant.new({:id =>"12337411"})
    assert_equal "12337411", m.id
  end

  def test_it_has_a_name
    m = Merchant.new({:name => "CJsDecor"})
    assert_equal "CJsDecor", m.name
  end

  def test_it_displays_when_it_was_created
    m = Merchant.new(:created_at)
    assert_equal "2011-12-09", m.created_at
  end

  def test_it_displays_when_it_was_updated
    m = Merchant.new(:updated_at)
    assert_equal "2016-01-08", m.updated_at
  end



end
