require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'salesanalyst'
require_relative 'merchant_repository'
class SalesEngine

  attr_reader :items,
              :merchants,
              :salesanalyst

  def initialize(item_path, merchant_path)
    @items = ItemRepository.new(item_path, self)
    @merchants = MerchantRepository.new(merchant_path,self)
    @salesanalyst = SalesAnalyst.new(self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items],file[:merchants])
  end
end
binding.pry
