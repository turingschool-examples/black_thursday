require_relative "item_repository"
require_relative "merchant_repository"
require 'pry'

class SalesEngine

  attr_reader :merchants,
              :items

  def from_csv(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants])
    @items     = ItemRepository.new(file_paths[:items], self)
  end

  def merchant_id_search(merchant_id)
    merchants.find_by_id(merchant_id)
  end
end
