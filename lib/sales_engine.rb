require "csv"
require_relative "merchant_repository"
require_relative "item_repository"
require 'bigdecimal'

class SalesEngine
  attr_accessor :merchants,
                :items
  def initialize
    @merchants = nil
    @items = nil
  end

  def self.from_csv(repos)
    se = SalesEngine.new
    se.merchants = se.pull_merchant_repository(repos[:merchants])
    se.items = se.pull_item_repository(repos[:items])

   return se
  end

  def pull_merchant_repository(file_path_merchant)
    mr = MerchantRepository.new
    total_merchants = CSV.read(file_path_merchant, headers: true, header_converters: :symbol)
    total_merchants.each do |merchant|
      m = Merchant.new({:id => merchant[:id].to_i, :name => merchant[:name]})
      mr.add_merchant(m)
    end
    mr
  end


  def pull_item_repository(file_path_item)
    it = ItemRepository.new
    total_items = CSV.read(file_path_item, headers: true, header_converters: :symbol)
    total_items.each do |item|
      i = Item.new({:id => item[:id].to_i, :name => item[:name], :description => item[:description],
                    :unit_price => BigDecimal.new(item[:unit_price].to_f/100,4), :created_at => item[:created_at],
                    :updated_at => item[:updated_at], :merchant_id => item[:merchant_id].to_i})
      it.add_item(i)
    end
    return it
  end
end
