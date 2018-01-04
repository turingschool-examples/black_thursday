require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine

  attr_reader :merchants,
              :items

  def from_csv(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants])
    @items     = ItemRepository.new(file_paths[:items])
  end

end
