require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analysis'

class SalesEngine

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def items
    @items ||= ItemRepository.new(path[:items], self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(path[:merchants], self)
  end

  def self.from_csv(path)
    se = SalesEngine.new(path)
  end
end

#memoization
#This operator only sets the variable if the variable is false or Nil.
