require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'file_reader'
require 'csv'

class SalesEngine
  include FileReader
  # builds access to items and merchants
  attr_reader :merchants, :items

  def initialize(file_path)
    @merchants = MerchantRepository.new(FileReader.load(file_path[:merchants]))
    @items = ItemRepository.new(FileReader.load(file_path[:items]))
  end
end
