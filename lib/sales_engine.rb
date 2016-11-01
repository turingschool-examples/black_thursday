require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :sales_info,
              :items,
              :merchants

  def self.from_csv(sales_info)
    @sales_info = sales_info
    @items      = make_item_repo
    @merchants  = make_merchant_repo
  end

  def self.make_item_repo
    ItemRepository.new(@sales_info[:items])
  end

  def self.make_merchant_repo
    MerchantRepository.new(@sales_info[:merchants])
  end

  def self.merchants
    @merchants
  end

  def self.items
    @items
  end

end