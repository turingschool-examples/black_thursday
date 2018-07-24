require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'

class SalesEngine
  include FileLoader

  attr_reader :data_files

  def initialize(data_files)
    @data_files = data_files
  end

  def self.from_csv(data_files)
    new(data_files)
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(data_files[:merchants]))
  end

  def items
    @items ||= ItemRepository.new(load_file(data_files[:items]))
  end

  def analyst
    SalesAnalyst.new
  end
end
