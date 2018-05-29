require './lib/items_repository'
require './lib/merchant_repo'
require 'csv'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(csv_hash)
    items = ItemsRepository.new
    merchants = MerchantRepo.new
    if csv_hash[:items]
      items_filepath = csv_hash[:items]
      csv_items = CSV.open items_filepath,
                        headers: true,
                        header_converters: :symbol
      items.load_items(csv_items)
    end
    if csv_hash[:merchants]
      merchants_filepath = csv_hash[:merchants]
      csv_merchants = CSV.open merchants_filepath,
                        headers: true,
                        header_converters: :symbol
      merchants.load_merchants(csv_merchants)
    end
    new(items, merchants)
  end
end