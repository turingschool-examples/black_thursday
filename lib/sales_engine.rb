require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(item_rows, merchant_rows)
    @items     = ItemRepository.new(item_rows, self)
    @merchants = MerchantRepository.new(merchant_rows, self)
  end

  def self.from_csv(paths)
    item_path  = paths[:items]
    merch_path = paths[:merchants]

    item_data  = CSV.open item_path, headers: true, header_converters: :symbol
    merch_data = CSV.open merch_path, headers: true, header_converters: :symbol

    SalesEngine.new(item_data, merch_data)
  end

  def all_merchant_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def merchant_by_item(merchant_id)
    merchants.find_by_id(merchant_id.to_s)
  end
end
