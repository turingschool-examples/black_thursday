require_relative 'file_loader'
require_relative 'merchant_repository'

class SalesEngine
  include FileLoader
  attr_reader :file_paths

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_hash)
    new(file_hash)
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(file_paths[:merchants]), self)
  end

  def items
    @items ||= ItemRepository.new(load_file(file_paths[:items]), self)
  end
end
