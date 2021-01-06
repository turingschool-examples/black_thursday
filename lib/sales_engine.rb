require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(arg1)
  @items = things(CSV.readlines(arg1[:items], headers: true, header_converters: :symbol))
  @merchants = people(CSV.readlines(arg1[:merchants], headers: true, header_converters: :symbol))
  end

  def self.from_csv(arg1)
    new(arg1)
  end

  def people(file)
    info = []
    file.each do |row|
      info.push(Merchant.new(row))
    end
    MerchantRepository.new(info)
  end

  def things(file)
    info = []
    file.each do |row|
      info.push(Item.new(row))
    end
    ItemRepository.new(info)
  end
end
