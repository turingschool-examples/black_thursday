require "./test/test_helper"
require "./lib/merchant"


class MerchantTest < Minitest::Test

  attr_reader :mr, :m

  def setup
    @mr = merchant_repository
    @m = Merchant.new(mr, {:id => 12334105, :name => "Turing School", :created_at => 2010-12-10, :updated_at => 2010-12-10})
  end 


  def test_it_exists
    assert_instance_of Merchant, m
  end

  def test_id_is_returned
    assert_equal 12334105, m.id
  end

  def test_id_is_integer
    assert_equal 12334105, m.id
  end

  def test_name_is_returned
    assert_equal "Turing School", m.name
  end


end
