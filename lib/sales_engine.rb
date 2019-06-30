require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/file_loader'
require 'pry'

class SalesEngine

  include FileLoader

  attr_accessor :items,
                :merchants

  def self.from_csv(hash)
    items_array = []
    merchants_array = []

    if hash[:items]
      items_array = load_csv(hash[:items], Item)
    end

    if hash[:merchants]
      merchants_array = load_csv(hash[:merchants], Merchant)
    end

    SalesEngine.new(items_array, merchants_array)
  end

  def self.load_csv(location, class_name)
    csv_array = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      csv_array << class_name.new(row)
    end
    csv_array
  end

  def initialize(items_array = [], merchants_array = [])
    @items = ItemRepository.new(items_array)
    @merchants = MerchantRepository.new(merchants_array)
  end


end
