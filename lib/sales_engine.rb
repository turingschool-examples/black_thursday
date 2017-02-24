require 'pry'
require './lib/merchant_repository'
require './lib/file_loader'

class SalesEngine
  attr_reader :merchants, :csv

  def initialize(file_paths)
    # @csv = file_paths
    @merchants = MerchantRepository.new(FileLoader.load_csv(file_paths[:merchants]))
    # @items = ItemRepository.new(FileLoader.new(file_paths[:items]))
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

end
