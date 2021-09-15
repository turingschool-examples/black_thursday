require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items

  def initialize
    # @items = data[:items]
    # @merchants = data[:merchants]
    @items = (all_item_data = []
      CSV.foreach("./data/items.csv", headers: true) do |row|
        all_item_data << row.to_hash
      end
      all_item_data)
    @merchants = (all_merchant_data = []
      CSV.foreach("./data/merchants.csv", headers: true) do |row|
        all_merchant_data << row.to_hash
      end
      all_merchant_data)
  end

  def item_data
    @items.each do |category|
      category
    end
  end
end
