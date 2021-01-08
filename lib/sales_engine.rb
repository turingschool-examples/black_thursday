require_relative './merchant_repo'
require_relative './item_repo'


class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @it_file = data[:items]
    @file = data[:merchants]
    @merchants = MerchantRepository.new(@file, self)
    @items = ItemRepository.new(@it_file, self)
  end

  def self.from_csv(data)
    new(data)
  end

  # def merchants
  #   @merchant_repo.build_merchants
  # end
end
