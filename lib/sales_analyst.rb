require 'bigdecimal'
require_relative './stats_module'

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :invoice_items

  include Stats

  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo,transaction_repo, customer_repo )
    @merchants         = merchant_repo.all
    @items             = item_repo.all
    @invoices          = invoice_repo.all
    @invoice_items     = invoice_item_repo.all
    @transactions      = transaction_repo.all
    @m_repo            = merchant_repo
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def merchant_item_list(merchant)
    @items.find_all do |item|
      item.merchant_id == merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant_array = @merchants.map do |m|
      merchant_item_list(m).count
    end
    (standard_dev(items_per_merchant_array)).round(2)
  end

  def merchants_with_high_item_count
    high_items = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count_merchs = []
    @merchants.each do |m|
      item_count = merchant_item_list(m).count
      if  item_count > high_items
        high_count_merchs << m
      end
    end
    high_count_merchs
  end

  def average_item_price_for_merchant(id)
    merchant = @m_repo.find_by_id(id)
    items = merchant_item_list(merchant)
    prices = items.map { |i| i.unit_price }
    (mean_value(prices)).round(2)
  end

  def average_average_price_per_merchant
    averages = @merchants.map do |m|
      average_item_price_for_merchant(m.id)
    end
    (mean_value(averages)).round(2)
  end

  def average_item_price
    item_prices = @items.map { |i| i.unit_price }
    mean_value(item_prices)
  end

  def average_item_price_std_dev
    item_prices = @items.map { |i| i.unit_price }
    standard_dev(item_prices)
  end

  def golden_items
    golden_price = (average_item_price_std_dev * 2) + average_item_price
    golden_array = []
    @items.each do |item|
      golden_array << item if item.unit_price >= golden_price
    end
    golden_array
  end

  def average_invoices_per_merchant
    (@invoices.count / @merchants.count.to_f).round(2)
  end

  def merchant_invoice_list(merchant)
      @invoices.find_all do |invoice|
        invoice.merchant_id == merchant.id
      end
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant_array = @merchants.map do |m|
        merchant_invoice_list(m).count
    end
    (standard_dev(invoices_per_merchant_array)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants_array = []
    two_deviations_above_mean = average_invoices_per_merchant_standard_deviation * 2 + average_invoices_per_merchant
    @merchants.each do |m|
        if  merchant_invoice_list(m).count > two_deviations_above_mean
           top_merchants_array << m
        end
    end
    top_merchants_array
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants_array = []
    two_deviations_below_mean = average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2
    @merchants.each do |m|
        if  merchant_invoice_list(m).count < two_deviations_below_mean
           bottom_merchants_array << m
        end
    end
    bottom_merchants_array
  end

  def top_days_by_invoice_count
    numbers_to_days_hash = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
    invoices_per_day = {"Sunday" => 0, "Monday" => 0, "Tuesday" => 0, "Wednesday" => 0, "Thursday" => 0, "Friday" => 0, "Saturday" => 0}

    @invoices.each do |invoice|
      day = numbers_to_days_hash[invoice.created_at.wday]
      invoices_per_day[day] += 1
    end

    average_invoices_per_day = mean_value(invoices_per_day.values)
    average_invoices_per_day_standard_deviation = standard_dev(invoices_per_day.values)
    one_deviation_above_mean = average_invoices_per_day + average_invoices_per_day_standard_deviation

    top_days_created = []
    invoices_per_day.each do |day, value|
      if value > one_deviation_above_mean
        top_days_created << day
      end
    end

    top_days_created
  end

  def invoice_status(status)
    status_total = 0
    @invoices.each do |invoice|
        if invoice.status == status
            status_total += 1
        end
    end
   ((status_total.to_f / @invoices.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
      transaction_match = @transactions.find_all do |transaction|
        transaction.invoice_id == invoice_id
      end
      transaction_match.any? do |transaction|
        transaction.result==:success
      end
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_items.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    total = invoice_items.inject(0.0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity)
    end
    if total == nil
      return 0
    else
      total
    end
  end

  def total_revenue_by_date(date)
     invoices_for_date = @invoices.find_all do |invoice|
      invoice.created_at == date && invoice_paid_in_full?(invoice.id)
    end
    invoices_for_date.inject(0) do |sum, invoice|
      sum + invoice_total(invoice.id)
    end
  end

  def revenue_by_merchant(merchant_id)
    sum = 0
     @invoices.each do |invoice|
     if invoice.merchant_id == merchant_id && invoice_paid_in_full?(invoice.id)
      sum += invoice_total(invoice.id)
     end
    end
    sum
  end

  def merchants_ranked_by_revenue
    revenue_array = []
    @merchants.each do |merchant|
      revenue_array << {merchant: merchant, revenue: revenue_by_merchant(merchant.id)}
    end
    revenue_array.sort_by! do |item|
      item[:revenue]
    end
    revenue_array.map do |hash|
      hash[:merchant]
    end.reverse
  end

  def top_revenue_earners(number = 20)
    merchants_ranked_by_revenue.first(number)
  end

  def pending_invoice?(invoice_id)
    @transactions.each do |trans|
      return false if trans.invoice_id == invoice_id &&
        trans.result == :success
    end
    true # if no transactions or no successful transactions
  end

  def pending_merchant?(merchant)
    merchant_invoice_list(merchant).any? do |invoice|
      pending_invoice?(invoice.id)
    end #if any merchant-invoice is not pending, then not a pending merchant
  end

  def merchants_with_pending_invoices
    pending_merchants = []
    @merchants.each do |merch|
      pending_merchants << merch if pending_merchant?(merch)
    end
    pending_merchants
  end

  def merchants_with_only_one_item
    one_item_merchants = []
    @merchants.each do |merchant|
      if merchant_item_list(merchant).count == 1
        one_item_merchants << merchant
      end
    end
    one_item_merchants
  end


  def merchants_with_only_one_item_registered_in_month(month_string)
    merchants_with_only_one_item.find_all do |merch|
      merch.created_at.strftime("%^B") == month_string.upcase
    end
  end


  def most_sold_item_for_merchant(merchant_id)
    valid_invoice_items = valid_invoice_items_for_merchant(merchant_id)
    count = 0
    most_sold_items = []
    valid_invoice_items.each do |vii|
      if vii.quantity >= count
        if vii.quantity > count
          most_sold_items = []
          count = vii.quantity
        end
        most_sold_items << item_by_id(vii.item_id)
      end
    end
    most_sold_items = most_sold_items.uniq
  end

  def best_item_for_merchant(merchant_id)
     valid_invoice_items = valid_invoice_items_for_merchant(merchant_id)
     high_total = 0
     best_item = nil
     valid_invoice_items.each do |vii|
       vii_total = vii.quantity * vii.unit_price
       if vii_total > high_total
         high_total = vii_total
         best_item = item_by_id(vii.item_id)
       end
     end
     best_item
   end

   ### HELPER METHODS FOR MOST SOLD & BEST ITEMS FOR MERCHANT ###

   def valid_invoice_items_for_merchant(merchant_id)
     merchant_invoices = get_merchant_invoices(merchant_id)
     valid_transactions = valid_transactions_from_invoices(merchant_invoices)
     invoice_items_from_transactions(valid_transactions)
   end

   def get_merchant_invoices(merchant_id)
     merchant_invoices = []
     @invoices.each do |inv|
       merchant_invoices << inv if inv.merchant_id == merchant_id
     end
     merchant_invoices
   end

   def valid_transactions_from_invoices(merchant_invoices)
     valid_transactions = []
     merchant_invoices.each do |m_inv|
       @transactions.each do |trans|
         if trans.invoice_id == m_inv.id && trans.result == :success
           valid_transactions << trans
         end
       end
     end
     valid_transactions
   end

   def invoice_items_from_transactions(valid_transactions)
     valid_invoice_items = []
     valid_transactions.each do |trans|
       @invoice_items.each do |ii|
         valid_invoice_items << ii if trans.invoice_id == ii.invoice_id
       end
     end
     valid_invoice_items
   end

   def item_by_id(item_id)
     @items.find{ |item| item.id == item_id }
   end

end
