require_relative 'statistics'
require 'date'

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
      invoice_items.each do |invoice_item|
        sum += invoice_item.unit_price
      end
    end
    sum
  end

  def top_revenue_earners(x=20)
    merchants_ranked_by_revenue[0..x-1]
  end

  def merchants_ranked_by_revenue
    return @merchants.all if @merchants.sorted == true
    @merchants.sorted = true
    @merchants.instances = @merchants.all.sort_by { |merchant|
      revenue_by_merchant(merchant.id)
    }.reverse
  end

  def merchants_with_pending_invoices
    invoices = @invoices.find_all_by_status(:pending)
    # invoices.each do |invoice|
    #   transactions = @transactions.find_all_by_invoice_id(invoice.id)
    #   transactions.each do |transaction|
    #     if transaction.result == :failed
    #       invoices.delete(invoice)
    #     end
    #   end
    # end
    invoices
  end

  def merchants_with_only_one_item
    @merchants.all.select do |merchant|
      @items.all.one? do |item|
        # require 'pry'; binding.pry
        item.merchant_id == merchant.id
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    month_num = Date::MONTHNAMES.find_index(month)

    merchant_id_hash = Hash.new(0)

    @invoices.all.each do |invoice|
      if invoice.created_at.month == month_num
        merchant_id_hash[invoice.merchant_id] += 1
      end
    end

    merchant_id_hash.map do |merchant_id, count|
      if count == 1
        @merchants.find_by_id(merchant_id)
      else
        nil
      end
    end.compact.select do |merchant|
      merchant.created_at.month == month_num
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = @invoices.all.select{|iv| iv.merchant_id == merchant_id }
    # non_returned_invoices = merchant_invoices.reject{|iv| iv.status == :returned}
    relevant_iv_ids = merchant_invoices.map(&:id)
    shipped_iv_ids = relevant_iv_ids.select do |invoice_id|
      @transactions.find_all_by_invoice_id(invoice_id).any?{|tr| tr.result == :success}
    end
    invoice_items = shipped_iv_ids.map do |iv_id|
      @invoice_items.find_all_by_invoice_id(iv_id)
    end
    return 0 if invoice_items.empty?
    invoice_items.flatten.map {|iv_item|
      iv_item.unit_price * iv_item.quantity
    }.reduce(&:+)
  end

  def most_sold_item_for_merchant(merchant_id)

  end

  def best_item_for_merchant(merchant_id)

  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions == []
    paid_in_full = true
    transactions.each do |transaction|
      paid_in_full = false unless transaction.result == :success
    end
    paid_in_full
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.reduce(0) do |sum, invoice_item|
      sum += invoice_item.revenue
      sum
    end
  end
end
