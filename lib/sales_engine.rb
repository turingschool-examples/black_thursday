require_relative './merchant'
require_relative './item'
require_relative './merchant_repository'
require_relative './item_repository'
require 'csv'

class SalesEngine
  attr_accessor :merchant_data, :item_data

  def initialize
    @merchant_data = nil
    @item_data = nil
  end

  def self.from_csv(data)
    sales_engine = SalesEngine.new
    sales_engine.merchant_data = data[:merchants]
    sales_engine.item_data = data[:items]
    sales_engine
  end

  def merchants
    merchant_repository = MerchantRepository.new
    array = []
    CSV.foreach(@merchant_data) do |row|
      array << row
    end
    array.reject! {|row| row[0][0] == "id"}
    array.each do |merchant|
      merchant_repository.create_with_id({id: merchant[0], name: merchant[1]})
    end
    merchant_repository
  end

  def items
    item_repository = ItemRepository.new
    array = []
    CSV.foreach(@item_data) do |row|
      array << row
    end
    array.delete_at(0)
    array.each do |item|
      item_repository.create_with_id({id: item[0],
                                      name: item[1],
                                      description: item[2],
                                      unit_price: item[3],
                                      merchant_id: item[4],
                                      created_at: item[5],
                                      updated_at: item[6]
                                      })
    end
    item_repository
  end

end
