require_relative 'file_loader'

class SalesEngine
  include FileLoader
  attr_reader :file_paths

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_hash)
    new(file_hash)
  end

  def merchant_file
    @merchants ||= MerchantRepository.new(load_file(file_paths[:merchants], self)
  end
end

  se = SalesEngine.from_csv({
  # :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})
puts se.merchant_file
