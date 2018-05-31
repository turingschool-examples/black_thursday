require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'file_reader'
require 'csv'

class SalesEngine
  include FileReader

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

  def analyst
    SalesAnalyst.new(self)
  end
end
