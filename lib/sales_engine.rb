require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :item_csv_path, :merchant_csv_path, :items, :merchants

  def initialize(hash)
    @item_csv_path = hash[:items]
    @merchant_csv_path = hash[:merchants]
    @items = ItemRepository.new(@item_csv_path, self)
    @merchants = MerchantRepository.new(@merchant_csv_path, self)
  end

  def self.from_csv(hash)
    self.new(hash)
  end

  # def items
  #   @item_repo
  # end
  #
  # def merchants
  #   @merchant_repo = MerchantRepository.new(@merchant_csv_path, self)
  # end

  def route(payload)
    case payload[0]
    when 'item_repository' then find_items_by_merchant_id(payload[1])
    end
  end

  def find_items_by_merchant_id(attribute_used)
    @items.find_all_by_merchant_id(attribute_used)
  end
end
