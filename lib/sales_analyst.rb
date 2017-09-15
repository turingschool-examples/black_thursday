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
    standard_deviation(@se.merchants.all, average_items_per_merchant )
  end

  def average_price_per_merchant_standard_deviation
    standard_deviation(@se.merchants.all, average_average_price_per_merchant )
  end

  # def average_items_per_merchant_standard_deviation
  #   average_count = average_items_per_merchant
  #   sum_of_squares = @se.merchants.all.reduce(0) do |sum, merchant|
  #     sum + (merchant.items.count - average_count) ** 2
  #   end
  #
  #   rounded Math.sqrt(sum_of_squares / (@se.merchants.all.count - 1))
  # end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    high_count_merchants = @se.merchants.all.find_all do |merchant|
        merchant.items.count > standard_deviation
      end
    high_count_merchants.map do |merchant|
      merchant.name
    end
  end

  def golden_items
    dbl_standard_deviation = average_price_per_merchant_standard_deviation * 2
    golden_items_merchants = @se.merchants.all.find_all do |merchant|
        merchant.items.count > standard_deviation
      end
    high_count_merchants.map do |merchant|
      merchant.item
    end
  end

  def standard_deviation(enum, average)
    count = enum.count
    average = average

    sum_of_squares = enum.reduce(0) do |sum, element|
      sum + (element - average) ** 2
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
