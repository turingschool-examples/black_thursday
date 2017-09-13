require './lib/items_repo'
require './lib/merchant_repo'

class SalesAnalyst

  attr_reader :merchants, :items

  def initialize(data)
    @merchants     = MerchantRepo.new(data[:merchants], self)
    @items         = ItemRepo.new(data[:items], self)
  end

  def self.from_csv(data)
    sa = SalesAnalyst.new(data)
  end

  def average_items_per_merchant
    average = @items.all_items.count.to_f
    average_1 = @merchants.all_merchants.count.to_f
    complete_average = average / average_1
    complete_average.round(2)
  end
  
end
