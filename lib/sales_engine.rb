require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(list_of_paths)
    @list_of_paths = list_of_paths
    @items = ItemRepository.new(read_items_data, self)
    @merchants = MerchantRepository.new(read_merchants_data, self)
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

  def find_items(id)
    items.find_all_by_merchant_id(id)
  end

end
