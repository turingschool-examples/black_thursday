require 'csv'
require_relative 'merchant_repository'
require_relative './item_repository'
require_relative './item'
require_relative './merchant'
require_relative './sales_analyst'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :analyst

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new



  end

  def self.from_csv(hash_path)

    sales_engine = new

    # TODO: refactor opportunity

    rows = CSV.open hash_path[:merchants], headers: true, header_converters: :symbol
    rows.each do |row|
      new_merchant = Merchant.new(row.to_h)
      sales_engine.merchants.all << new_merchant
    end

    rows = CSV.open hash_path[:items], headers: true, header_converters: :symbol
    rows.each do |row|
      # require 'pry'; binding.pry
      # id = row[:created_at]
      describe = row[:description].partition("\n")[0]
      row[:description] = describe
      # require 'pry'; binding.pry
      new_item = Item.new(row.to_h)
      sales_engine.items.all << new_item
      # puts row
    end
    # require 'pry'; binding.pry

    sales_engine
  end

  def analyst
    # require 'pry'; binding.pry
        @analyst = SalesAnalyst.new(self)
        # KR why is analyst an attribute value?

  end
end
