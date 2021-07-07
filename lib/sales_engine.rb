require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'

class SalesEngine
  include FileLoader
  attr_reader :info

  def initialize(info)
    @info = info
  end

  def self.from_csv(info)
    new(info)
  end

  def items
    @items ||= ItemRepository.new(load_file(info[:items]))
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(info[:merchants]))
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
  end




end
