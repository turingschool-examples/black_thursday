require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items, :merchants, :analyst

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(populate_merchants(merchants))
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(info)
    self.new(info[:items], info[:merchants])
  end
  
  def populate_merchants(file_path)
    file = CSV.read(file_path, headers: true, header_converters: :symbol )
    file.map do |row|
      Merchant.new(row)
    end
  end

end
