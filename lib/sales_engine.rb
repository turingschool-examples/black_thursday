require './lib/merchant_repository'
require './lib/item_repository'
class SalesEngine

    def from_csv(info)
        @merchant_csv_filepath = info[:merchants]
        @item_csv_filepath = info[:items]
    end

    def merchants
      MerchantRepository.new(@merchant_csv_filepath)
    end

    def items
      ItemRepository.new(@item_csv_filepath)
    end
end
