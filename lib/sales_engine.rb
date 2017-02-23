require "./lib/merchant_repository"
require "./lib/item_repository"

class SalesEngine
    attr_accessor :paths
  def initialize (hash)
    @paths = hash
  end

  def self.from_csv(hash)
    files = hash.each_pair do |key, value|
      @paths[key] = value
    end
    SalesEngine.new(files)
  end

  def merchants
    MerchantRepository.new(@paths[:merchants], self)
  end

  def items
    ItemRepository.new(@paths[:items], self)
  end 
end
