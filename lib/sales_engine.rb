require_relative 'merchant_repository'
require_relative 'item_repository'


class SalesEngine
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

  def items
    @items ||= ItemRepository.new(load_file(data[:items]))
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(data[:merchants]))
  end

end
