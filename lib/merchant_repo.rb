require './lib/merchant'

class MerchantRepo

  # @@file_name = './data/merchants.csv'

  # def initialize
  #
  # end

  def all
    merchant1 = Merchant.new({:id => 1, :name => "etsy"})
    merchant2 = Merchant.new({:id => 2, :name => "ebay"})
    merchant3 = Merchant.new({:id => 3, :name => "ampeg"})
    merchant4 = Merchant.new({:id => 4, :name => "amazon"})
    merchant5 = Merchant.new({:id => 5, :name => "fender"})
  end
end
