require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items, :merchants, :analyst

  def initialize(arg1)
    @items = item_repository(CSV.readlines(arg1[:items], headers: true, header_converters: :symbol))
    @merchants = merchant_repository(CSV.readlines(arg1[:merchants], headers: true, header_converters: :symbol))
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(arg1)
    new(arg1)
  end

  def merchant_repository(file)
    info = []
    file.each do |row|
      info.push(Merchant.new(row))
    end
    MerchantRepository.new(info)
  end

  def item_repository(file)
    info = []
    file.each do |row|
      info.push(Item.new(row))
    end
    ItemRepository.new(info)
  end

  def all_merchants
   @merchants.all
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def all_items
    @items.all
  end
end
