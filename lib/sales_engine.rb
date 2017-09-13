require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(csv_file_paths)
    item_file_path = csv_file_paths[:items]
    merchant_file_path = csv_file_paths[:merchants]

    items = ItemRepository.new(item_file_path)
    merchants = MerchantRepository.new(merchant_file_path)
    SalesEngine.new(items, merchants)
  end


  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

end
