require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'csv_parser'

class SalesEngine
  attr_reader  :merchants_data, :items_data

  def initialize(items_data, merchants_data)
    @items_data = items_data
    @merchants_data = merchants_data
  end


  def self.from_csv(csv_content)
    items_csv = csv_content[:items]
    merchants_csv = csv_content[:merchants]
    items_data = CsvParser.new.items(items_csv)
    merchants_data = CsvParser.new.merchants(merchants_csv)
    SalesEngine.new(items_data, merchants_data)
  end

  def items
    ItemRepository.new(items_data)
  end

  def merchants
    MerchantRepository.new(merchants_data)
  end

end
