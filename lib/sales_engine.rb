require_relative "merchant_repository"
require_relative "item_repository"

class SalesEngine
    attr_accessor :paths, :items, :merchants
  def initialize (hash)
    @paths = hash
    @items = ItemRepository.new(@paths[:items], self)
    @merchants = MerchantRepository.new(@paths[:merchants], self)
  end

  def self.from_csv(hash)
    files = hash.each_pair do |key, value|
      @paths[key] = value
    end
    SalesEngine.new(files)
  end
end
