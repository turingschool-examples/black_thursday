require_relative './file_loader'
require_relative './merchant_repository'
# require_relative './item_repository'

class SalesEngine
  attr_reader     :location

  def self.from_csv(location)
    SalesEngine.new(location)
  end

  def initialize(location)
    @file_loader = FileLoader.new(location)
    @location = location
  end

  def merchants
    merchant_location = @file_loader.builder(location[:merchants])
    @merchants ||= MerchantRepository.new(merchant_location)
  end


end
