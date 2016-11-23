require 'pry'
require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(hash)
    @items     =  ItemRepository.new(hash[:items], self)
    @merchants =  MerchantRepository.new(hash[:merchants], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def load_items
    items.all.group_by do |item_instance|
      item_instance.merchant_id
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(id)
    @merchants.find_by_id(id)
  end
end
