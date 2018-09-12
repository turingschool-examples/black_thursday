require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './sales_analyst'
require 'CSV'

class SalesEngine
  attr_reader :ir,
              :mr

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

  def analyst
    sales_analyst = SalesAnalyst.new(@mr, @ir)
  end

end
