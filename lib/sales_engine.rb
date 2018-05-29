require 'csv'
require_relative 'file_loader.rb'
require_relative 'merchant_repository.rb'

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

end
