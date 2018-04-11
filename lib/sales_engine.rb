require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'class_relationships'

class SalesEngine
  include sales_relationships
  attr_accessor :items, :merchants

  def initialize(path)
    @path = path
  end

   def self.from_csv(path)
    SalesEngine.new(path)
  end

  def items
    @items ||= ItemRepository.new(File.load(path[:items]), self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(File.load(path[:merchants]), self)
  end
end
