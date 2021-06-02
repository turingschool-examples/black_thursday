require './lib/itemrepository'
require './lib/merchantrepository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(paths)
    @items     = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
  end

  def self.from_csv(paths)
    # require 'pry'; binding.pry
    new(paths)
  end
end
