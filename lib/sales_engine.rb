require_relative 'merchant_repo'
require_relative 'item_repo'

class SalesEngine
  attr_reader :item_repo, :merchant_repo

  def initialize(data)
    @item_repo = ItemRepo.new(data[:items], self)
    @merchant_repo = MerchantRepo.new(data[:merchants], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
