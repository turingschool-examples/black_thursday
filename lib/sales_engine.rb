require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine < ItemRepository
  attr_accessor :items, :merchants, :hash
  # def initialize
  # end
  def self.from_csv(info)
    # @hash = info
    @merchants = MerchantRepository.new(info.fetch(:merchants))
    @items = ItemRepository.new(info.fetch(:items))
    # binding.pry
  end
  # def items
  #   @items = ItemRepository.new(@hash[:items])
  # end
  # def merchants
  #   @merchants = MerchantRepository.new(@hash[:merchants])
  # end
end
