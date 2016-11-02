require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader   :items,
                :merchants

  def self.from_CSV(paths)
    @items = ItemRepository.new(paths[:items])
  end

end


