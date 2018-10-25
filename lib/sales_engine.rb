require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'csv'
class SalesEngine
  attr_reader :items, :merchants
  def initialize(data)
    @item_data = CSV.open(data[:items], headers: true, header_converters: :symbol)
    @merchant_data = CSV.open(data[:merchants], headers: true, header_converters: :symbol)
    @items      = ItemRepository.new(@items_collection)
    @merchants  = MerchantRepository.new(@merchants_collection)
    @items_collection = []
    @merchants_collection = []
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def create_items
    @item_data.each do |row|
      @items_collection << Item.new({
                               id: row[:id].to_s,
                               name: row[:name].to_s,
                               description: row[:description].to_s,
                               unit_price: BigDecimal.new(row[:unit_price].to_s),
                               merchant_id: row[:merchant_id].to_s,
                               created_at: row[:created_at].to_s,
                               updated_at: row[:updated_at].to_s
                             })
    end
    @items_collection
  end

  def create_merchants
    @merchant_data.each do |row|
      @merchants_collection << Merchant.new({id: "#{row[:id]}", name: "#{row[:name]}"})
    end
    @merchants_collection
  end
end
