require './lib/item_repository'
require './lib/merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items_path, merchants_path)
    @items = ItemRepository.new(csv_rows(items_path))
    @merchants = MerchantRepository.new(csv_rows(merchants_path))
  end

  def csv_rows(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    file.to_a
  end

  def self.from_csv(hash)
    items_path = hash[:items]
    merchants_path = hash[:merchants]
    self.new(items_path, merchants_path)
  end
end
