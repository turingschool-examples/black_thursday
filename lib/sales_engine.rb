require 'bigdecimal'
require 'csv'
require_relative 'fileio'
require_relative 'item_repository'
require_relative 'merchant_repository'
# Sales Engine class for managing data
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(item_repo, merchant_repo)
    @items = item_repo
    @merchants = merchant_repo
  end

  def self.from_csv(items_and_merchants)
    items_file_path = FileIO.load(items_and_merchants[:items])
    items_repo = ItemRepository.new(items_file_path)
    merchants_file_path = FileIO.load(items_and_merchants[:merchants])
    merchants_repo = MerchantRepository.new(merchants_file_path)
    new(items_repo, merchants_repo)
  end
end
