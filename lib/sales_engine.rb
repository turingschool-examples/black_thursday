require_relative './items_repo'
require_relative './merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst

  def self.from_csv(data)
    new(data)
  end

  def initialize(data)
    @items = ItemsRepo.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @analyst = Analyst.new(self)
  end
end
