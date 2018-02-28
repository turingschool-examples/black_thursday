# Statistics for SalesEngine
class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def mean_finder(item_array)
    mean = 0.0
    item_array.each { |count| mean += count }
    return 0 if item_array.length.zero?
    mean / item_array.length
  end

  def standard_devation(mean, item_array)
    std_dev = 0.0
    item_array.each { |count| std_dev += (count - mean)**2 }
    std_dev /= item_array.length - 1
    Math.sqrt(std_dev)
  end

  def average_items_per_merchant
    mean_finder(items_count_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    num_items = items_count_per_merchant
    standard_devation(mean_finder(num_items), num_items).round(2)
  end

  def items_count_per_merchant
    @se.merchants.all.map do |merchant|
      @se.find_items_by_merchant_id(merchant.id).length
    end
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    @se.merchants.all.find_all do |merchant|
      @se.find_items_by_merchant_id(merchant.id).length > (std_dev + mean)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @se.find_items_by_merchant_id(merchant_id)
    mean_finder(items.map(&:unit_price)).round(2)
  end

  def average_average_price_per_merchant
    avg_array = @se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean_finder(avg_array).round(2)
  end

  def golden_items
    item_array = @se.items.all
    price_array = item_array.map(&:unit_price)
    mean = mean_finder(price_array)
    std_dev = standard_devation(mean, price_array)
    item_array.find_all { |item| item.unit_price > ((std_dev * 2) + mean) }
  end

  def average_invoices_per_merchant
    mean_finder(invoice_count_per_merchant).round(2)
  end

  def invoice_count_per_merchant
    @se.merchants.all.map do |merchant|
      @se.find_invoices_by_merchant_id(merchant.id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_list = invoice_count_per_merchant
    mean = mean_finder(invoice_count_per_merchant)
    standard_devation(mean, invoice_list).round(2)
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    @se.merchants.all.find_all do |merchant|
      @se.find_invoices_by_merchant_id(merchant.id)\
         .length > ((std_dev * 2) + mean)
    end
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    @se.merchants.all.find_all do |merchant|
      @se.find_invoices_by_merchant_id(merchant.id)\
         .length < (mean - (std_dev * 2))
    end
  end

  def top_days_by_invoice_count
    days = invoice_days
    mean = mean_finder(days.values)
    std_dev = standard_devation(mean, days.values)
    days = days.find_all { |_day, count| count > (std_dev + mean) }
    days.map { |day| day[0] }
  end

  def invoice_days
    invoices = @se.invoices.all
    invoices = invoices.map { |invoice| invoice.created_at.strftime('%A') }
    days = { 'Monday' => 0, 'Tuesday' => 0, 'Wednesday' => 0, 'Thursday' => 0,
             'Friday' => 0, 'Saturday' => 0, 'Sunday' => 0 }
    invoices.each { |day| days[day] += 1 }
    days
  end

  def invoice_status(check)
    invoices = @se.invoices.all.map(&:status)
    (100 * invoices.count(check) / invoices.length.to_f).round(2)
  end

  def total_revenue_by_date(date)
    invoices = @se.invoices.all.find_all do |invoice|
      invoice.created_at.year == date.year && \
        invoice.created_at.mon == date.mon && \
        invoice.created_at.mday == date.mday
    end
    invoices.map! do |invoice|
      @se.invoice_items.find_all_by_invoice_id(invoice.id)
    end
    amount = 0
    invoices.each do |invoice_item|
      invoice_item.each do |item|
        amount += item.unit_price * item.quantity
      end
    end
    amount
  end

  def merchants_with_pending_invoices
    @se.merchants.all.find_all do |merchant|
      check_if_merchant_invoices_are_successful(merchant)
    end
  end

  def check_if_merchant_invoices_are_successful(merchant)
    merchant.invoices.any? do |invoice|
      invoice.transactions.none? { |sale| sale.result == 'success' }
    end
  end

  def merchants_with_only_one_item
    @se.merchants.all.find_all { |merchant| merchant.items.count == 1 }
  end

  def top_revenue_earners(max = 20)
    merchants_ranked_by_revenue[0...max]
  end

  def merchants_ranked_by_revenue
    @se.merchants.all.sort_by(&:revenue).reverse
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month_name
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices = @se.find_invoices_by_merchant_id(merchant_id)
    revenue = 0
    invoices.each do |invoice|
      invoice_item = @se.find_invoice_items_by_invoice_id(invoice.id)
      invoice_item.each do |item|
        revenue += item.quantity * item.unit_price
      end
    end
    revenue
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = @se.find_invoices_by_merchant_id(merchant_id)
    items = {}
    invoices.each do |invoice|
      next unless invoice.is_paid_in_full?
      invoice_items = @se.find_invoice_items_by_invoice_id(invoice.id)
      invoice_items.each do |invoice_item|
        if items.key?(invoice_item.item_id)
          items[invoice_item.item_id] += invoice_item.quantity
        else
          items[invoice_item.item_id] = invoice_item.quantity
        end
      end
    end
    best_value = (items.max_by { |_, value| value })[1]
    items = items.find_all { |_, value| value == best_value }
    best = items.map do |item|
      @se.find_item_by_id(item[0])
    end
    best
  end

  def best_item_for_merchant(merchant_id)
    invoices = @se.find_invoices_by_merchant_id(merchant_id)
    items = {}
    invoices.each do |invoice|
      next unless invoice.is_paid_in_full?
      invoice_items = @se.find_invoice_items_by_invoice_id(invoice.id)
      invoice_items.each do |iitem|
        if items.key?(iitem.item_id)
          items[iitem.item_id] += iitem.quantity * iitem.unit_price
        else
          items[iitem.item_id] = iitem.quantity * iitem.unit_price
        end
      end
    end
    best_item_id = (items.max_by { |_, value| value })[0]
    @se.find_item_by_id(best_item_id)
  end
end
