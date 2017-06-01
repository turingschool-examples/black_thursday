require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :files, :merchants, :items
  def initialize(files)
    @files = files
    @merchants = MerchantRepository.new(files[:merchants])
    @items = ItemRepository.new(files[:items])
    
  end

  def self.from_csv(files)
    new(files)
  end

  # def merchants
  #   i = 0
  #   CSV.foreach('./data/merchants_test.csv', row_sep: :auto) do |line|
  #     i += 1
  #     next if i == 1
  #     @merchants.populate_merchants(line)
  #   end
  # end

  # def items
  #   i = 0
  #   CSV.foreach('./data/items_test.csv', row_sep: :auto) do |line|
  #     i += 1
  #     next if i == 1
  #     ir.populate_items(line)
  #   end
  # end
end
