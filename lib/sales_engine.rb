require 'csv'
require 'pry'
require_relative 'merchant_repository'

class SalesEngine
attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
  end

  def self.from_csv(input)
    merchant_lines = File.readlines input[:merchants]
    item_lines = File.readlines input[:items]
    SalesEngine.new(merchant_lines, item_lines)
  end

  # def merchants
  #   MerchantRepository.new(@merchant_lines)
  #   # binding.pry
  # end
  #
  # def items
  #   ItemRepository.new(@item_lines)
  # end

end
