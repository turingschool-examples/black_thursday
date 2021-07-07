require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'


class SalesEngine
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

  def items
    ItemRepository.new(data[:items])
  end

  def merchants
    MerchantRepository.new(data[:merchants])
  end

end
