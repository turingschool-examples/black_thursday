require_relative "item_repository"
require_relative "merchant_repo"

class SalesEngine
  attr_reader   :item_path,
                :merchant_path

  def initialize(item_path, merchant_path)
    @item_path      = item_path
    @merchant_path  = merchant_path
  end

  def self.from_csv(file_path)
    item_path      = file_path[:items]
    merchant_path  = file_path[:merchants]

    SalesEngine.new(item_path, merchant_path)
  end

  def merchants
    MerchantRepo.new(@merchant_path)
  end

  def items
    ItemRepository.new(@item_path)
  end
end