require './lib/merchant_repo'


class SalesEngine
  attr_reader :items

  def initialize(data)
    @items = data[:items]
    @file = data[:merchants]
    @merchant_repo = MerchantRepository.new(@file)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def merchants
    @merchant_repo.build_merchants
  end
end
