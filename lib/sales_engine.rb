require  "./lib/item_repository"
require  "./lib/merchant_repository"
require "csv"
require "pry"

class SalesEngine

  attr_reader :items, :merchants

  def initialize(files_to_load)
    items_csv = CSV.open(files_to_load[:items], headers:true, header_converters: :symbol)
    merchants_csv = CSV.open(files_to_load[:merchants], headers:true, header_converters: :symbol)
    @items = ItemRepository.new(items_csv, self)
    @merchants = MerchantRepository.new(merchants_csv, self)

  end

  def self.from_csv(files_to_load)
      self.new(files_to_load)
  end

end
