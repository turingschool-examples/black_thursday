require 'bigdecimal'
require 'pry'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    merchants = @se.merchants.all.count.to_f
    items = @se.items.all.count
    rounded(items / merchants)
  end

  def average_average_price_per_merchant
    rounded average(@se.merchants.all){ |merchant| average_item_price(merchant) }
  end

  def average_item_price_for_merchant(id)
    merchant = @se.merchants.find_by_id(id)
    rounded average_item_price(merchant)
  end

  def average_item_price(merchant)
    average(merchant.items){ |item| item.unit_price }
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(@se.merchants.all) do |merchant|
      merchant.items.count.to_f
    end
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    high_count_merchants = @se.merchants.all.find_all do |merchant|
        merchant.items.count > standard_deviation
      end
    high_count_merchants.map do |merchant|
      merchant.name
    end
  end

  def average_price_per_merchant_standard_deviation
    standard_deviation(@se.merchants.all) do |merchant|
      average_item_price(merchant)
    end
  end

  def golden_items
    golden_price = average_price_per_merchant_standard_deviation * 2 + average_price
    @se.items.all.find_all do |item|
      item.unit_price > golden_price
    end
  end

  def average_price
    average(@se.items.all) {|item| item.unit_price }
  end

  def standard_deviation(enum, &block)
    enum_average = average(enum, &block)
    count = enum.count

    sum_of_squares = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + (element - enum_average) ** 2
      else
        count -= 1
        sum
      end
    end
    rounded Math.sqrt(sum_of_squares / (count - 1))
  end

  def average(enum)
    count = enum.count

    sum = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + element
      else
        count -= 1
        sum
      end
    end
    return nil if count.zero?
    sum / count
  end

  def rounded(answer)
    answer.round(2)
  end

end
