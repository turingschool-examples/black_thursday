require_relative './merchant_repository'

class SalesEngine

  attr_reader     :merchants,
                  :items

  def self.from_csv(csv_hash)
    merchants_csv = csv_hash[:merchants]
    items_csv = csv_hash[:items]

    SalesEngine.new(merchants_csv, items_csv)
  end

  def initialize(merchants_csv, items_csv)
    @merchants = MerchantRepository.new(merchants_csv)
    @items = ItemsRepository.new(items_csv)
  end

end
