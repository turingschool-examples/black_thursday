require 'time'

class SalesAnalyst
  attr_reader :items

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
      if transaction.result == :success
        results << true
      else
        results << false
      end
    end
    results.any?(true)
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
      if invoice.created_at.strftime("%F") == date.strftime("%F")
        total_revenue += invoice_total(invoice.id)
      end
    end
    total_revenue
  end


  def top_revenue_earners(num = 20)
    merchant_total_revenue_hash = Hash.new(0)
    @invoices.all.each do |invoice|
      merchant_total_revenue_hash[invoice.merchant_id]  += invoice_total(invoice.id)
    end
    array = merchant_total_revenue_hash.sort_by do |merchant_id, total|
      - total
    end
    array.first(num).map do |merchant_id_array|
      @merchants.find_by_id(merchant_id_array[0])
    end
  end

  def merchants_with_only_one_item
    merchant_array = []
    @merchants.all.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length == 1
        merchant_array << merchant
      end
    end
    merchant_array
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchant_month_array = []
    @merchants.all.each do |merchant|
      if merchant.created_at.strftime('%B') == month
        merchant_month_array << merchant
      end
    end
    merchant_array = []
    merchant_month_array.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length == 1
        merchant_array << merchant
      end
    end
    merchant_array
  end


  def revenue_by_merchant(merchant_id)
    merchant_total_revenue_hash = Hash.new(0)
    @invoices.all.each do |invoice|
      merchant_total_revenue_hash[invoice.merchant_id]  += invoice_total(invoice.id)
    end
    merchant_total_revenue_hash[merchant_id]
  end

  def merchants_with_pending_invoices
      @invoices.all.map do |invoice|
        if invoice_paid_in_full?(invoice.id) == false
          @merchants.find_by_id(invoice.merchant_id)
        end
      end.uniq.compact
  end

    def invoice_items_for_merchant(merchant_id)
      items_for_merchant = @items.find_all_by_merchant_id(merchant_id)

      items_for_merchant.map do |item|
        @invoice_items.find_all_by_item_id(item.id)
      end.flatten
    end

    def invoice_items_by_quantity(merchant_id)
      invoice_items_for_merchant(merchant_id).each_with_object({}) do |invoice_item, items_by_quantity|
        if items_by_quantity[invoice_item.item_id]
          items_by_quantity[invoice_item.item_id] += invoice_item.quantity
        else
          items_by_quantity[invoice_item.item_id] = invoice_item.quantity
        end
      end
    end

    def most_sold_item_for_merchant(merchant_id)
      invoice_array = invoice_items_by_quantity(merchant_id).sort_by do |item_id, quantity|
        - quantity
      end

      if invoice_array[0][1] != invoice_array[1][1]
        [@items.find_by_id(invoice_array[0][0])]
      else
        invoice_array.map do |array|
          if invoice_array[0][1] == array[1]
            @items.find_by_id(array[0])
          end
        end
      end
    end

    def invoice_items_by_revenue(merchant_id)
      invoice_items_for_merchant(merchant_id).each_with_object({}) do |invoice_item, items_by_revenue|
        if items_by_revenue[invoice_item.item_id]
          items_by_revenue[invoice_item.item_id] += (invoice_item.quantity * invoice_item.unit_price)
        else
          items_by_revenue[invoice_item.item_id] = (invoice_item.quantity * invoice_item.unit_price)
        end
      end
    end

    def best_item_for_merchant(merchant_id)
      invoice_array = invoice_items_by_revenue(merchant_id).sort_by do |item_id, revenue|
        - revenue
      end
      @items.find_by_id(invoice_array[0][0])
    end

    def top_buyers(num = 20)
      customer_total_purchase_hash = Hash.new(0)
      @invoices.all.each do |invoice|
        customer_total_purchase_hash[invoice.customer_id]  += invoice_total(invoice.id)
      end
      array = customer_total_purchase_hash.sort_by do |merchant_id, total|
        - total
      end
      array.first(num).map do |customer_id_array|
        @customers.find_by_id(customer_id_array[0])
      end
    end

    def top_merchant_for_customer(customer_id)
      invoice_array = @invoices.find_all_by_customer_id(customer_id)
      invoice_item_array = []
      invoice_array.each do |invoice|
        invoice_item_array = @invoice_items.find_all_by_invoice_id(invoice_id)
      end
      invoice_item_array.each_with_object({}) do |invoice_item|
        
      end
    end
end
