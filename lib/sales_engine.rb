
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(csv_hash) # <= {merchant: MerchantRepo.new(), item: ItemRepo.new(), ...}
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    @items     = ItemRepository.new(csv_hash[:items])
    # @merchants = repos[:merchant_repository]
  end

  def self.from_csv(csv_hash)
   new(csv_hash)
  end

  def analyst
     SalesAnalyst.new
  end

end
