module MerchantAnalyst
    def items_per_merchant
       @sales_engine.merchant_repo.merchants.map do |merchant|
            id = merchant.id
            @sales_engine.item_repo.find_all_by_merchant_id(id).length
        end
    end

    def average_items_per_merchant
        num_per_merchant = items_per_merchant
        average = (num_per_merchant.inject(:+) / num_per_merchant.length)
    end

    def average_items_per_merchant_standard_deviation
        items = items_per_merchant
        average = average_items_per_merchant
        standard_deviation(items, average)
    end

    def merchants_with_high_item_count
        items = items_per_merchant
        average = average_items_per_merchant
        std = standard_deviation(items, average)
        
        merchants.all.find_all do |merchant|
            merchant.items.count > (average + std)
        end
    end

    def average_item_price_for_merchant(merchant_id)
       merchant = merchants.find_by_id(merchant_id)
       item_prices = merchant.items.map do |item|
            item.price.round(1)
       end
       average(item_prices)
    end

    def average_average_price_per_merchant
        merchants_average = merchants.all.map do |merchant|
            average_item_price_for_merchant(merchant.id)
        end
        average(merchants_average)
    end
end