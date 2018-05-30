require 'csv'
require 'bigdecimal'
require_relative 'file_loader.rb'
require_relative 'merchant_repository.rb'
require_relative 'item_repository'
require_relative 'sales_analyst'

class SalesEngine
  include FileLoader
  attr_reader :merchants,
              :items
  def initialize(file_paths)
    @file_paths = file_paths
    @merchants ||= MerchantRepository.new(load(file_paths[:merchants]))
    @items ||= ItemRepository.new(load(file_paths[:items]))
  end
  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
