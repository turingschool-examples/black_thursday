require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'

# This class births all our repositories
class SalesEngine
  def initialize(file_hash)
    @location_hash = file_hash
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def items
    ItemRepository.new(CSV.parse(File.read(@location_hash[:items]), headers: true))
  end

  def merchants
    MerchantRepository.new(CSV.parse(File.read(@location_hash[:merchants]), headers: true))
  end
end
