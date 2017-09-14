require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(csv_file_paths)
    item_file_path = csv_file_paths[:items]
    merchant_file_path = csv_file_paths[:merchants]

    SalesEngine.new(item_file_path, merchant_file_path)
  end


  def initialize(item_file_path, merchant_file_path)
    @items = ItemRepository.new(item_file_path, self)
    @merchants = MerchantRepository.new(merchant_file_path, self)
  end

end
