require 'pry'

require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'



class SalesEngine

  attr_reader :items, :merchants

  def initialize (items = nil, merchants = nil)
    @items      = items
    @merchants  = merchants
  end

  def self.from_csv(hash)
    merch_repo = make_merch_repo(hash)
    item_repo = make_item_repo(hash)
    self.new(item_repo, merch_repo)
  end

  def self.make_merch_repo(hash)
    merchants_path = hash[:merchants]
    @merchants = MerchantRepository.new(merchants_path)
  end

  def self.make_item_repo(hash)
    items_path = hash[:items]
    @items = ItemRepository.new(items_path)
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
