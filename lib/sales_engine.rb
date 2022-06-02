require_relative("./item")
require_relative("./item_repository")
require_relative("./merchant")
require_relative("./merchant_repository")

class SalesEngine
  attr_reader :item_repository, :merchants

  def initialize(items_path, merchant_path)
    # @item_repository = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchant_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end
end
