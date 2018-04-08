require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def self.from_csv(path)
    SalesEngine.new(path)

  end

  def items
    # require 'pry'; binding.pry
    @items ||= ItemRepository.new(@path[:items])
  end

  def merchants
    @merchants ||= MerchantRepository.new(@path[:merchants])
  end
end
