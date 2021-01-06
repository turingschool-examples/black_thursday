class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(hash)
    make_merchant_repo(hash)
    make_item_repo(hash)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def make_merchant_repo(hash)
    @merchants = MerchantRepo.new(hash[:merchants])
  end

  def make_item_repo(hash)
    @items = ItemRepo.new(hash[:items])
  end
end
