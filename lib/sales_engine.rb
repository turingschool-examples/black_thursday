require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'

class SalesEngine


    attr_reader :merchants, :items

  def initialize(merchant_repository, item_repository)
    @merchants = merchant_repository
    @items = item_repository
  end

  def self.from_csv(file_paths)
    items = 0
    merchants = MerchantRepository.new
    # @items = ItemRepository.new
    # item_path = file_paths[:items]
    merchant_path = file_paths[:merchants]
    # parse_merchants(merchant_path)
    CSV.foreach(merchant_path) do |row|
      merchants.add_merchant(Merchant.new({:id => row[0].to_i, :name => row[1]}))
    end
    binding.pry
    SalesEngine.new(merchants, items)
  end

  # def parse_merchants(merchant_path)
  #   merchants = []
  #   CSV.foreach(merchant_path) do |row|
  #     binding.pry
  #     merchants << (Merchant.new({:id => row[0].to_i, :name => row[1]}))
  #   end
  #   merchants
  # end

end
