require_relative 'item_repository'
# require_relative 'merchant_repository'

class SalesEngine
  attr_reader :item_csv_path, :merchant_csv_path

  def from_csv(hash)
    @item_csv_path = hash[:items]
    @merchant_csv_path = hash[:merchants]
  end

  def items
    ItemRepository.new(@item_csv_path, self)
  end

  # def merchants
  #   MerchantRepository.new(@merchant_csv_path, self)
  # end
end
