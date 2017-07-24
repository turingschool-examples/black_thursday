require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :files

  def initialize
    # @files = nil
  end

  def from_csv(csv_hash)
    @files = csv_hash
  end

  def items
    ItemRepository.new(@files[:items])
  end

  def merchants
    MerchantRepository.new(@files[:merchants])
  end
end
