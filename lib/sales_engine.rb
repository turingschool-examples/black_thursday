require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'file_reader'
require 'csv'

class SalesEngine
  include FileReader
  # builds access to items and merchants
  # attr_reader :merchants, :items

  # def self.from_csv(file_path)
  #   @items = ItemRepository.new(FileReader.load(file_path[:items]))
  #   @merchants = MerchantRepository.new(FileReader.load(file_path[:merchants]))
  # end

# end

  def initialize(file_path)
    @file_path = file_path
  end

  def self.from_csv(file_path)
    new(file_path)
  end

  def merchants
    MerchantRepository.new(FileReader.load(@file_path[:merchants]))
  end

  def items
    ItemRepository.new(FileReader.load(@file_path[:items]))
  end
end
