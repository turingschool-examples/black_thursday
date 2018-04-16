module Calculator
    def standard_deviation
        items = items_per_merchant
        average = average_items_per_merchant
        difference = difference(items, average)
        squared = square(difference)
        sum = squared.sum
        num_minus_one = squared.length - 1
        variance = sum / num_minus_one
        Math.sqrt(variance).round(2)
    end

    def difference(items_per_merchant, average)
        items_per_merchant.map do |item|
            item - average
        end
    end

    def square(difference)
        difference.map do |index|
            (index ** 2)
        end
    end

    def divide(difference)
        num_minus_one = difference.length - 1
    end
end