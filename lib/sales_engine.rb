require 'pry'

class SalesEngine

  attr_accessor   :items,
                  :merchants

  def initialize
    @items      = ItemRepository.new(self)
    @merchants  = MerchantRepository.new(self)
  end

  def self.from_csv(repo)
    items_CSV = repo[:items]
    merchants_CSV = repo[:merchants]

    se = SalesEngine.new
    se.items.populate(items_CSV)
    se.merchants.populate(merchants_CSV)
    binding.pry
    return se
  end
end
