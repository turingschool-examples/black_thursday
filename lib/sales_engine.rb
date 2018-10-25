require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './sales_analyst'
require_relative './csv_reader'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(merchant_repository, item_repository)
    @merchants = merchant_repository
    @items = item_repository
  end

  def self.from_csv(file_paths)
    mr = MerchantRepository.new
    ir = ItemRepository.new
    merchants = CSVReader.parse_merchants(mr, file_paths[:merchants])
    items = CSVReader.parse_items(ir, file_paths[:items])
    SalesEngine.new(merchants, items)
  end

  def analyst
    SalesAnalyst.new({merchants: @merchants, items: @items})
  end
end
