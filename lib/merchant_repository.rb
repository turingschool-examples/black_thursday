require './lib/sales_engine'

class MerchantRepository < SalesEngine
  attr_reader :merchants_array
  def initialize(merchants_array)
    @merchants_array = merchants_array
  end



end
