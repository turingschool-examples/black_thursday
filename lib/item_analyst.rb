module ItemAnalyst
    def golden_items
        items_price = items.all.map { |item| item.price }
        average = average(items_price)
        std = standard_deviation(items_price, average)
        golden_items = items.all.find_all do |item|
            by_deviation(item.price, average, std, 2)
        end
        sorted_golden_items = golden_items.sort_by {|item| item.price}.reverse
    end
end