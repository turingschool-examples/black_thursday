require "csv"
require "pry"
require_relative "./merchant_repository"
class SalesEngine
  attr_reader :items_path,
              :merchants_path

  def initialize(sales_data)
    @items_path = sales_data[:items]
    @merchants_path = sales_data[:merchants]
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end

  def items
    ItemRepository.new(@items_path)
  end

  def merchants
    MerchantRepository.new(@merchants_path)
        binding.pry
  end


end
