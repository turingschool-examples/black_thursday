<<<<<<< HEAD
require ''

class SalesEngine

  def initialize(hash)
    @hash = hash
  end



=======
require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(info)
    items = ItemRepository.new(info[:items])
    merchants = MerchantRepository.new(info[:merchants])
    new(items, merchants)
  end
>>>>>>> bddd64d2125297e5dc0691787f428dad3e602939
end
