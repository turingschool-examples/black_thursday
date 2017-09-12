require_relative 'merchant_repo'
require_relative 'item_repo'
require 'pry'
class SalesEngine

  def self.from_csv(data_hash)
    new(data_hash)
  end

  def initialize(data_hash)
    @merchant_repo = MerchantRepo.new(data_hash[:merchants])
    @item_repo = ItemRepo.new(data_hash[:items])
  end

  def merchants
    @merchant_repo
  end

  def items
    @item_repo
  end

end
