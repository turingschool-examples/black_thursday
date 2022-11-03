require 'csv'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './item'
require_relative './item_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end

  def self.from_csv(data)
    mr = MerchantRepository.new
    ir = ItemRepository.new

    CSV.foreach(data[:merchants], headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.new(row)

      mr.add_merchant_to_repo(merchant)
    end

    CSV.foreach(data[:items], headers: true, header_converters: :symbol) do |row|
      item = Item.new(row)

      ir.add_to_repo(item)
    end
    SalesEngine.new(mr, ir)
  end

  def analyst 
    SalesAnalyst.new(@items, @merchants)
    # this method requires #from_csv to be called first
  end

end
