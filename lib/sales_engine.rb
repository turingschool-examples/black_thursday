require_relative("./item")
require_relative("./item_repository")
require_relative("./merchant")
require_relative("./merchant_repository")
require_relative("./sales_analyst.rb")

class SalesEngine
  attr_reader :item_repository, :merchant_repository

  def initialize(items_path, merchant_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchant_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end

  def analyst
    SalesAnalyst.new(@item_repository, @merchant_repository)
  end
end
