require 'csv'
require './lib/items_repository'
require './lib/merchants_repository'

class SalesEngine

  def initialize(info)
    @items = info[:items]
    @merchants = info[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  def items
    ItemsRepository.new(@items)
  end

end #SalesEngine class end
