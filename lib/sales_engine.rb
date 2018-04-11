require_relative 'merchant_repo'
require_relative 'item_repo'

class SalesEngine
  attr_accessor :items, :merchants

  def self.from_csv(hash)
    new(hash)
  end

  def initialize(hash)
    # @items = ItemRepo.new
    @merchants = MerchantRepo.new(hash[:merchants])

  end
end
