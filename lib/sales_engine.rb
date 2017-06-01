require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine
  def initialize(item_rows, merchant_rows)
    @items     = ItemRepository.new(item_rows)
    @merchants = MerchantRepository.new(merchant_rows)
  end

  def self.from_csv(paths)
    item_path  = paths[:items]
    merch_path = paths[:merchants]

    item_data  = CSV.open item_path, headers: true, header_converters: :symbol
    merch_data = CSV.open merch_path, headers: true, header_converters: :symbol

    SalesEngine.new(item_data, merch_data)
  end
  #
  # def self.from_csv(attrs)
  #   item_path = attrs[:items]
  #   merchants_path = attrs[:merchants]
  #
  #   item_data = CSV.open item_path, headers: true, header_converters: :symbol
  #   merchants_data = CSV.open merchants_path, headers: true, header_converters: :symbol
  #
  #   se = SalesEngine.new(item_data, merchants_data)
  # end


end
