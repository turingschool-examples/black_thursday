require 'pry'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'

# put load paths in separate file

class SalesEngine
  attr_reader :path

    def initialize(path)
      @path = path
    end

    def self.from_csv(path)
      SalesEngine.new(path)
    end

    def items
      @items ||= ItemRepository.new(Loader.load(path[:items]), self)
    end

    def merchants
      @merchants ||= MerchantRepository.new(Loader.load(path[:merchants]), self)
    end
  end
