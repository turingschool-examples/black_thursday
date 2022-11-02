require 'csv'
require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
class SalesEngine

  def initialize(csv_hash)
    @item_csv = csv_hash[:items]
    @merchant_csv = csv_hash[:merchants]
  end

  def items
    items = []
    contents = CSV.open @item_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      items.push(Item.new({:id => row[:id],
                           :name => row[:name],
                           :description => row[:description],
                           :unit_price => row[:unit_price],
                           :created_at => row[:created_at],
                           :updated_at => row[:updated_at],
                           :merchant_id => row[:merchant_id]}))
    end
    item_repo = ItemRepository.new(items)
  end


  def merchants
    merchants = []
    contents = CSV.open @merchant_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      merchants.push(Merchant.new({:id => row[:id],
                                   :name => row[:name]}))
    end
    merchant_repo = MerchantRepository.new(merchants)
  end
end
