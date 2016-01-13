require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine
attr_reader :items_file, :merchants_file, :items_data

  def initialize(list_of_csv_files)
    @items_file = list_of_csv_files[:items]
    @merchants_file = list_of_csv_files[:merchants]
    merchants
    items
  end

  def self.from_csv(list_of_csv_files)
    SalesEngine.new(list_of_csv_files)
  end

  def items
    merchants.item_repository
  end

  def merchants
    MerchantRepository.new(merchants_file, items_file)
  end
end
