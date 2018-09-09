
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  def initialize(csv_hash) # <= {merchant: MerchantRepo.new(), item: ItemRepo.new(), ...}
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    # @merchants = repos[:merchant_repository]
  end

  def self.from_csv(csv_hash)
    new(csv_hash)
  end

end
