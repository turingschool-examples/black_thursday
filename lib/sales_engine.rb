require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require 'CSV'

class SalesEngine
  attr_reader :items_file,
              :merchants_file

  def initialize(file_path_hash)
    @mr = MerchantRepository.new(file_path_hash[:merchants])
    @ir = ItemRepository.new(file_path_hash[:items])
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def merchants
    @mr
  end

  def items
    @ir
  end
end
