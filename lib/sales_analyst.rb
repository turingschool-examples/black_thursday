require_relative 'statistics'
class SalesAnalyst
  include Statistics
  attr_reader :items, :merchants, :invoices, :invoice_items, :customers, :transactions
  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
  end

  def average_type_per_type(type_1, type_2)
    (type_1.all.size.to_f / type_2.all.size).round(2)
  end

  def average_items_per_merchant
    average_type_per_type(@items, @merchants)
  end

  def average_invoices_per_merchant
    average_type_per_type(@invoices, @merchants)
  end

  def average_items_per_merchant_standard_deviation
    items_per_each_merchant = @items.all.group_by{|item|item.merchant_id}.map{|k,v|v.size}
    standard_deviation(*items_per_each_merchant).round(2)
  end
  def average_invoices_per_merchant_standard_deviation
    invoices_per_each_merchant = @invoices.all.group_by{|iv|iv.merchant_id}.map{|k,v|v.size}
    standard_deviation(*invoices_per_each_merchant).round(2)
  end

  def merchants_with_high_item_count
    temp_sd = average_items_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_items_of_merchant(merchant) > average_items_per_merchant + temp_sd
    end
  end
  def top_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_invoices_of_merchant(merchant) > average_invoices_per_merchant + temp_sd * 2
    end
  end
  def bottom_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_invoices_of_merchant(merchant) < average_invoices_per_merchant - temp_sd * 2
    end
  end

  def average_item_price_for_merchant(merchant_id)
    prices = @items.find_all_by_merchant_id(merchant_id).map(&:unit_price)
    return nil if prices == []
    BigDecimal(average(*prices).to_f.round(2).to_s)
  end

  def average_average_price_per_merchant
    averages = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(*averages).round(2)
  end

  def golden_items
    item_prices = @items.all.map(&:unit_price)
    item_prices_std_dev = standard_deviation(*item_prices)
    average_item_price = average(*item_prices)
    @items.all.select do |item|
      item.unit_price > average_item_price + item_prices_std_dev * 2
    end
  end

  def num_items_of_merchant(merchant)
    @items.find_all_by_merchant_id(merchant.id).size
  end

  def invoice_status(status)
    invoice_count = @invoices.all.count
    status_sum = @invoices.all.reduce(0) do |sum, invoice|
      sum += 1 if invoice.status == status
      sum
    end
    (status_sum.to_f / invoice_count * 100).round(2)
  end

  def num_invoices_of_merchant(merchant)
    @invoices.find_all_by_merchant_id(merchant.id).size
  end

  def top_days_by_invoice_count
    temp_days_with_count = days_with_count
    av = average(*temp_days_with_count.values)
    temp_sd = standard_deviation(*temp_days_with_count.values)
    temp_days_with_count.select{|day,count| count > av + temp_sd}.keys
  end

  def each_invoice_day
    @invoices.all.map{|iv| iv.created_at.strftime("%A")}
  end

  def days_with_count
    days = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    days.map{|day| [day, each_invoice_day.count(day)]}.to_h
  end

  def total_revenue_by_date(date)
    sum = 0
    invoices = @invoices.find_all_by_date(date)

    invoices.each do |invoice|
      invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
      #binding.pry
      invoice_items.each do |invoice_item|
        sum += invoice_item.revenue
      end
    end
    sum
  end

  def top_revenue_earners(x=20)
    out = []
    return
    merchant_ids = @merchants.all.map do |merchant|
      merchant.id
    end

    x.times do
      top = 0
      add = false
      #binding.pry
      merchant_ids.each do |merchant_id|
        invoices = @invoices.find_all_by_merchant_id(merchant_id)
        invoices.each do |invoice|
          invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
          merchant_revenue = 0
          invoice_items.each do |invoice_item|
            merchant_revenue += invoice_item.unit_price * invoice_item.quantity
          end
          if merchant_revenue > top
            top = merchant_revenue
            add = true
          end
        end
        out << @merchants.find_all_by_merchant_id(merchant_id) if add
      end
    end
  end

  def merchants_ranked_by_revenue
    @merchants.all.sort do |merchant|
      revenue_by_merchant(merchant.id)
    end
  end

  def merchants_with_pending_invoices
w
  end

  def merchants_with_only_one_item

  end

  def merchants_with_only_one_item_registered_in_month(month)

  end

  def revenue_by_merchant(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)

    sum = 0
    invoices.each do |invoice|
      invoice_items = @invoice
      sum += invoice.unit_price * invoice.quantity
    end
  end

  def most_sold_item_for_merchant(merchant_id)

  end

  def best_item_for_merchant(merchant_id)

  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions == []
    result = true
    transactions.each do |transaction|
      if transaction.result != :success
        result = false
      end
    end
    result
  end
end
