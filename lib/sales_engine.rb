require 'csv'
require 'pry'
require_relative '../lib/merchantrepository'
require_relative '../lib/item_repository'
class SalesEngine
  attr_reader :items,
              :merchants,
              :merchant_data,
              :item_data

  def self.from_csv(sales_data)
    @merchant_data = CSV.open(sales_data[:merchants], headers: true, header_converters: :symbol)
    @item_data = CSV.open(sales_data[:items], headers: true, header_converters: :symbol)
    se = SalesEngine.new
    se.create_merchant_repo(@merchant_data)
    se.create_item_repo(@item_data)
    se
  end

  def create_merchant_repo(merchant_data)
    @merchants = MerchantRepository.new
    merchant_data.each do |merchant|
      @merchants.create({id: merchant[:id], name: merchant[:name], created_at: merchant[:created_at], updated_at: merchant[:updated_at]})
    end
  end

  def create_item_repo(item_data)
    @items = ItemRepository.new
    item_data.each do |item|
      @items.create({id: item[:id], name: item[:name],
                        description: item[:description],
                        unit_price: item[:unit_price],
                        created_at: item[:created_at],
                        updated_at: item[:updated_at],
                        merchant_id: item[:merchant_id]})
    end
  end
end
