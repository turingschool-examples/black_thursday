require 'Csv'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
  end

  def self.from_csv(file_path_hash)
    items_objs = CSV.read(file_path_hash[:items],
    headers: true, header_converters: :symbol)
    merchant_objs = CSV.read(file_path_hash[:merchants],
    headers: true, header_converters: :symbol)
    item_merchant_hash = {
      items: items_objs,
      merchants: merchant_objs
    }
    se = SalesEngine.new
    se.create_and_populate_item_repo(items_objs)
    se.create_and_populate_merchant_repo(merchant_objs)
    return se
  end

  def create_and_populate_item_repo(items_objs)
    items_objs.each do |item|
      @items.create(item)
    end
  end

  def create_and_populate_merchant_repo(merchant_objs)
    merchant_objs.each do |item|
      @merchants.create(item)
    end
  end

  def analyst
    SalesAnalyst.new
  end
end
