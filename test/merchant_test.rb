require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_has_id_and_name
    merch = Merchant.new({:id => 1234, :name => "Turing School"})
    
    assert_equal 1234, merch.id
    assert_equal "Turing School", merch.name
  end

  def test_it_knows_created_and_updated_date
    merch = Merchant.new({:created_at => "2012-12-12", :updated_at => "2016-10-31"})

    assert_equal "2012-12-12", merch.created
    assert_equal "2016-10-31", merch.updated
  end
  
end