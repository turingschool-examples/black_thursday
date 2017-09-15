require_relative 'merchant_repo'
require_relative 'item_repo'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    sales_engine = SalesEngine.new(items, merchants)
  end

  attr_reader :merchants, :items

  def initialize(items, merchants)
    @items = ItemRepository.new(items, self)
    @merchants = MerchantRepository.new(merchants, self)
  end
end
