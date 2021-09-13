require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :item_path, :merchant_path
  def self.from_csv(path)
    item_path = path[:items]
    merchant_path = path[:merchants]
  end

  def initialize
    @item_repository
    @merchant_repository
  end
end
