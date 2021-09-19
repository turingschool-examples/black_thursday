require 'time'

class SalesAnalyst

  def initialize(items, merchants, customers, invoices, invoice_items, transactions)
    @items              = items
    @merchants          = merchants
    @customers          = customers
    @invoices           = invoices
    @invoice_items      = invoice_items
    @transactions       = transactions
  end


  def average_items_per_merchant
    sum = items_per_merchant.sum
    average = sum.to_f/@merchants.all.length
    average.round(2)
  end

  def items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant

    sum = items_per_merchant.sum do |item_per_merchant|
      (item_per_merchant - mean) ** 2
    end

    sum /= (@merchants.all.length - 1)
    Math.sqrt(sum).round(2)
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant

    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length > (sd + mean)
    end
  end

  def average_item_price_for_merchant(id)
    sum = @items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end

    (sum / @items.find_all_by_merchant_id(id).length ).round(2)
  end

  def average_average_price_per_merchant
    sum = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    (sum / @merchants.all.length).round(2)
  end

  def golden_items
    average = average_average_price_per_merchant

    sum = @items.all.sum do |item|
      (item.unit_price - average) ** 2
    end

    sum /= (@items.all.length - 1)
    sd = Math.sqrt(sum)

    @items.all.select do |item|
      item.unit_price > ((sd * 2) + average)
    end
  end

  def average_invoices_per_merchant
    sum = @merchants.all.sum do | merchant |
      @invoices.find_all_by_merchant_id(merchant.id).length
    end

    (sum.to_f / @merchants.all.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant

    sum = @merchants.all.sum do | merchant |
      (@invoices.find_all_by_merchant_id(merchant.id).length - mean) ** 2
    end

    sum /= (@merchants.all.length - 1)
    Math.sqrt(sum).round(2)
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation

    @merchants.all.select do | merchant |
      @invoices.find_all_by_merchant_id(merchant.id).length > (mean + (sd * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation

    @merchants.all.select do | merchant |
      @invoices.find_all_by_merchant_id(merchant.id).length < (mean - (sd * 2))
    end
  end

  def top_days_by_invoice_count
    days = {
      'Sunday' => 0,
      'Monday' => 0,
      'Tuesday' => 0,
      'Wednesday' => 0,
      'Thursday' => 0,
      'Friday' => 0,
      'Saturday' => 0
    }

    #counting the number of times that each day has orders
    @invoices.all.each do | invoice |
      if invoice.created_at.wday == 0
        days['Sunday'] += 1
      elsif invoice.created_at.wday == 1
        days['Monday'] += 1
      elsif invoice.created_at.wday == 2
        days['Tuesday'] += 1
      elsif invoice.created_at.wday == 3
        days['Wednesday'] += 1
      elsif invoice.created_at.wday == 4
        days['Thursday'] += 1
      elsif invoice.created_at.wday == 5
        days['Friday'] += 1
      elsif invoice.created_at.wday == 6
        days['Saturday'] += 1
      end
    end

    #finding the mean
    sum = days.values.sum do | day_count |
      day_count
    end

    mean = sum / 7.0

    #finding the standard deviation
    sd_sum = days.values.sum do | day |
      (day - mean) ** 2
    end

    sd = Math.sqrt((sd_sum / 6))

    #finding top days
    high_days = days.select do | day, orders |
      orders > (mean + sd)
    end

    high_days.to_h

    high_days.keys
  end

  def invoice_status(status)
    status_count = Hash.new(0)

    @invoices.all.each do | invoice |
      status_count[invoice.status] += 1
    end

    ((100.0  * status_count[status]) / @invoices.all.length).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    results = []
    @transactions.find_all_by_invoice_id(invoice_id).each do |transaction|
      if transaction.result == "success"
        results << true
      else
        results << false
      end
    end
    results.all?(true)
  end

def invoice_total(invoice_id)

end

end
