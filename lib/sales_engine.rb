require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'csv_parser'

class SalesEngine
  attr_reader  :merchants_data, :items_data

  def initialize(items_data, merchants_data)
    @items_data = items_data
    @merchants_data = merchants_data
    set_merchant_items
  end


  def self.from_csv(csv_content)
    items_csv = csv_content[:items]
    merchants_csv = csv_content[:merchants]
    items_data = CsvParser.new.items(items_csv)
    merchants_data = CsvParser.new.merchants(merchants_csv)
    SalesEngine.new(items_data, merchants_data)
  end

  def items
    @items ||= ItemRepository.new(items_data)
  end

  def merchants
    @merchants ||= MerchantRepository.new(merchants_data)
  end

  def items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def set_merchant_items
    merchants.all.each do |merchant|
      merchant.items = items_by_merchant_id(merchant.id)
    end
  end

  def merchant_by_item_id(item)
    merchant.find_by_id(item.merchant_id)
  end

  def set_item_merchant
    items.all.each do |item|
       item.merchant = merchant_by_item_id(item)
    require 'pry' ; binding.pry
    end
  end

end
