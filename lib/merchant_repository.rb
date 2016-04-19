require './lib/merchant'
require './lib/sales_engine'

class MerchantRepository
  attr_accessor :merchants

  def initialize
    @merchants = []
  end

  def <<(merch_obj)
    @merchants.push(merch_obj)
  end

end
