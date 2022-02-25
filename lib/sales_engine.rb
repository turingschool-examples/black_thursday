require 'csv'
require 'pry'


class SalesEngine
attr_reader :merchant_lines, :item_lines
  def initialize(data)
    @merchant_lines = data[0]
    @item_lines = data[1]
  end

  def self.from_csv(input)
    merchant_lines = File.readlines input[:merchants]
    item_lines = File.readlines input[:items]
    [merchant_lines, item_lines]
  end

  def merchants
    MerchantRepository.new(@merchant_lines)
    # binding.pry
  end

  def items
    ItemRepository.new(@item_lines)
  end

end
