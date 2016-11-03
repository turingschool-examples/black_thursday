require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesEngine

  attr_reader :sales_info,
              :items,
              :merchants

  def self.from_csv(sales_info)
    new(sales_info)
  end

  def initialize(sales_info)
    @items     = make_item_repo(sales_info)
    @merchants = make_merchant_repo(sales_info)
  end

  def make_item_repo(sales_info)
    ItemRepository.new(sales_info[:items], self)
  end

  def make_merchant_repo(sales_info)
    MerchantRepository.new(sales_info[:merchants], self)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_item_merchant_by_merch_id(id)
    merchants.find_by_id(id)
  end

  def all_merchants
    merchants.all
  end

  def all_items
    items.all
  end

end