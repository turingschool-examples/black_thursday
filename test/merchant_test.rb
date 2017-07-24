require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test

  # id,name,created_at,updated_at
  #,2010-12-10,2011-12-04
  # m = Merchant.new({:id => 5, :name => "Turing School"})
  def test_it_exists
  merchant = Merchant.new({:id => 12334105, :name => 'Shopin1901'})

  assert_instance_of Merchant, merchant
  end


  # def test_it_can_load_one_merchant
  # merchant = Merchant.new
  #
  # assert_equals 12334105, merchant.id
# end


end
