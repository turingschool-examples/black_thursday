require_relative './merchant_repository'
require_relative './merchant'
require_relative './item_repository'
require_relative './item'
require 'csv'
require 'bigdecimal'
require 'time'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(merchants_filepath, items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @items = ItemRepository.new(items_filepath)
  end

  def self.from_csv(filepath_hash)
    merchants_filepath = filepath_hash[:merchants]
    items_filepath = filepath_hash[:items]
    SalesEngine.new(merchants_filepath, items_filepath)
  end

end
