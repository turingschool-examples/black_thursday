module Analyzable
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

  def invoice_total(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id).sum do |invoice_item|
      if invoice_paid_in_full?(invoice_id)
        invoice_item.quantity * invoice_item.unit_price
      else
        0
      end
    end
  end

  def total_revenue_by_date(date)
    total_revenue = 0.0
    @invoices.all.each do |invoice|
      if invoice.created_at.strftime('%F') == date.strftime('%F')
        total_revenue += invoice_total(invoice.id)
      end
    end
    total_revenue
  end
  
  def revenue_by_merchant(merchant_id)
    merchant_total_revenue_hash = Hash.new(0)
    @invoices.all.each do |invoice|
      merchant_total_revenue_hash[invoice.merchant_id]  += invoice_total(invoice.id)
    end
    merchant_total_revenue_hash[merchant_id]
  end
end