require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'item'
require_relative 'merchant'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    item_repo = ItemRepository.read_items_file(items, self)
    merchant_repo = MerchantRepository.read_merchants_file(merchants, self)
    sales_engine = SalesEngine.new(item_repo, merchant_repo)
  end

  attr_reader :merchants, :items

  def initialize(items, merchants)
    @merchants = merchants
    @items = items
  end
end
