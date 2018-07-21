require_relative './merchant'
require_relative './merchant_repository'
require 'csv'

class SalesEngine
  attr_accessor :merchant_data

  def initialize
    @merchant_data = nil
  end

  def self.from_csv(data)
    sales_engine = SalesEngine.new
    sales_engine.merchant_data = data[:merchants]
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
end
