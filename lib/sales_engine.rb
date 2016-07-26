require 'CSV'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(list_of_paths)
    @list_of_paths = list_of_paths
    @items = ItemRepository.new(read_items_data)
    @merchants = MerchantRepository.new(read_merchants_data)
  end

  def self.from_csv(list_of_paths)
    SalesEngine.new(list_of_paths)
  end

  def read_items_data
    read_data(:items)
  end

  def read_merchants_data
    read_data(:merchants)
  end

  def read_data(what_to_read)
    CSV.read(@list_of_paths[what_to_read], headers: true, header_converters: :symbol)
  end

end
