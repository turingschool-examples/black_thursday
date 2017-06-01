require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  def initialize(params = {})
    @items = params.fetch(:items, "")
    @merchants = params.fetch(:merchants, "")
  end

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def merchants
    mr = MerchantRepository.new
    # mr.create_merchants(merchants)
  end

  def items
    ir = ItemRepository.new
  end 

end
