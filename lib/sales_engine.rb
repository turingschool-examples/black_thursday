require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'item'

class SalesEngine
  def self.from_csv(information_and_location)
    items = information_and_location[:items]
    merchants = information_and_location[:merchants]
    SalesEngine.new(items, merchants)
  end

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def items
    items = []
    CSV.foreach(@items, headers: true, header_converters: :symbol) do |row|
      items << Item.new(row)
    end
    ItemRepository.new(items)
  end

  def merchants
    merchants = []
    CSV.foreach(@merchants, headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end
    MerchantRepository.new(merchants)
  end
end
