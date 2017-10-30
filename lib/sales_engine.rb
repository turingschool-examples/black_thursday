require './lib/item_repo'
# require './lib/merchant_repo'

class SalesEngine


# mr = MerchantRepo.new(filename, self)
# ItemRepo.new(filename, self)
# OrderRepo.new(filename, self)
  def item_repository
    ItemRepo.new #(filename, self)
  end

  def self.from_csv

  end

  def merchant(merchant)
    mr.merchant(merchant)
  end
end
