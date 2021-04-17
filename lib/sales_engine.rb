require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'

class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(paths)
    @items = ItemRepo.new(paths[:items], self)
    @merchants = MerchantRepo.new(paths[:merchants], self)
    @transactions = TransactionRepo.new(paths[:merchants], self)
  end

  def self.from_csv(paths)
    new(paths)
  end
  # self.from_csv(hash from i0 directions) => paths
  # from csv method will call initialize to pass
  # the hash through, should return the instance of itself
end
