require_relative 'merchant_repository'
# require_relative 'itemrepository'
require 'csv'
require 'pry'

class SalesEngine

  attr_reader :merchants
              #:items,


  # def initialize(item_path, merchant_path)
  #   @items = ItemRepository.new(item_path,self)
  #   @merchants = MerchantRepository.new(merchant_path,self)
  # end

  def initialize(merchant_path)
    @merchants = MerchantRepository.new(merchant_path,self)
  end

  # def self.from_csv(file = {})
  #   SalesEngine.new(file[:items], file[:merchants])
  # end

  def self.from_csv(file = {})
    SalesEngine.new(file[:merchants])
  end

binding.pry
end
