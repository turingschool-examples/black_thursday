require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader :merchants, :items

  # def initialize
  #   @merchants = MerchantRepository.new
  #   @items = ItemRepository.new
  # end

  # def from_csv(file_paths)
  #   # item_path = file_paths[:items]
  #   merchant_path = file_paths[:merchants]
  #   # parse_merchants(merchant_path)
  #
  #
  # end

  def parse_merchants(merchant_path)
    CSV.foreach(merchant_path) do |row|
      binding.pry
      # @merchants.add_merchant(Merchant.new({:id => row[0].to_i, :name => row[1]}))
    end
  end

end
