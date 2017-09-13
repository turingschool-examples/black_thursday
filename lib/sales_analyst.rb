require 'bigdecimal'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    merchant_count = @se.merchants.all.count
    item_count = @se.items.all.count
  end

  def average_average_price_per_merchant
    sum = @se.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price(merchant)
    end
  end

  def average_item_price_for_merchant(id)
    merchant = @se.merchants.find_by_id(id)
    average_item_price(merchant)
  end

  def average_item_price(merchant)
    average(merchant.items){ |item| item.unit_price }
    # items = merchant.items
    # sum = items.reduce(0){ |sum, item| sum + item.unit_price }
    # sum / items.count
  end

  def average(enum)
    sum = enum.reduce(0) do |sum, element|
      require 'pry'; binding.pry
      element = yield element if block_given?
      sum + element
    end
    sum / enum.size
  end

end
