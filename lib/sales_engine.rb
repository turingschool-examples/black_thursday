require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine
attr_reader :files, :items, :merchants

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    load_data(files)
    relationships
  end

  def load_data(files)
    @merchants = MerchantRepository.new(files[:merchants])
    @items = ItemRepository.new(files[:items])
  end

  def relationships
    merchant_to_item_relationship
    item_to_merchant_relationship
  end

  def merchant_to_item_relationship
    merchants.all.each do |merchant|
      merchant.items = items.find_all_by_merchant_id(merchant.id)
    end
  end

  def item_to_merchant_relationship
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end

end
