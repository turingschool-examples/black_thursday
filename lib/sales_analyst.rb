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

  def average_invoices_per_merchant
    merchants = @se.merchants.all.count.to_f
    invoices = @se.invoices.all.count
    rounded(invoices / merchants)
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

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(@se.merchants.all) do |merchant|
      merchant.invoices.count.to_f
    end
  end

  def top_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    top_players = avg + (2 * std_dev)
    @se.merchants.find_all do |merchant|
       merchant.invoices.count > top_players
    end
  end

  def bottom_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    bottom_players = avg - (2 * std_dev)
    @se.merchants.find_all do |merchant|
       merchant.invoices.count < bottom_players
    end
  end

  def average_invoice_count_per_day
    average(@se.invoices.all){ |invoice| invoice.created_at }
  end

  def top_days_by_invoice_count
    day_counts = @se.invoices.all.each_with_object(Hash.new(0)) do |invoice, counts|
      day = invoice.created_at.strftime('%A')
      counts[day] += 1
    end
    avg = average(day_counts.each_value)
    std_dev = standard_deviation(day_counts.each_value)
    threshold = avg + std_dev
    day_counts.select{ |day, count| count > threshold }.map(&:first)
  end

  def invoice_status(status)
    total = @se.invoices.all.count
    with_status = @se.invoices.all.count { |invoice| invoice.status == status }
    rounded (with_status * 100.0 / total)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    threshold = avg + std_dev

    @se.merchants.find_all do |merchant|
      merchant.items.count > threshold
    end
  end

  def average_price_per_merchant_standard_deviation
    standard_deviation(@se.merchants.all) do |merchant|
      average_item_price(merchant)
    end
  end

  def golden_items
    std_dev = standard_deviation(@se.items.all){ |item| item.unit_price }
    golden_price = average_price + (2 * std_dev)
    @se.items.find_all do |item|
      item.unit_price > golden_price
    end
  end

  def average_price
    average(@se.items.all) { |item| item.unit_price }
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

  def revenue_by_merchant(merchant_id)
    @se.merchants.find_by_id(merchant_id).total_revenue
  end

  def top_revenue_earners(count = 20)
    merchants_ranked_by_revenue.first(count)
  end

  def merchants_ranked_by_revenue
    @se.merchants.all.sort_by{ |merchant| -merchant.total_revenue }
  end

  def rounded(answer)
    answer.round(2)
  end

end
