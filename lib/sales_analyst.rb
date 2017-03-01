require 'date'

class SalesAnalyst
  attr_reader :engine,
              :set,
              :squared_differences,
              :items_by_merchant,
              :total_price_per_merchant,
              :total_avgs,
              :total_prices,
              :price_set,
              :price_squared_differences,
              :invoice_set,
              :invoices_squared_differences,
              :invoices_by_day,
              :invoices_by_date,
              :merchants_by_revenue,
              :merchants_pending,
              :merchants_one_item

  def initialize(engine="")
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count / engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @set ||= engine.merchants.all.map do |merchant|
      merchant.items.count
    end
    @squared_differences ||= set.map { |num| (num - average_items_per_merchant) ** 2 }
    (Math.sqrt( ( squared_differences.reduce(:+) ) / (set.count - 1) )).round(2)
    # Math.sqrt( ( (2-0.67)**2+(0-0.67)**2+(0-0.67)**2 ) / 2 )
  end

  def merchants_with_high_item_count
    engine.merchants.all.select do |merchant|
      merchant.items.count > (average_items_per_merchant_standard_deviation + average_items_per_merchant)
    end
  end

  def average_item_price_for_merchant(merch_id)
    @items_by_merchant = engine.merchants.find_by_id(merch_id).items
    @total_price_per_merchant = items_by_merchant.reduce(0) do |total, item|
      total + item.unit_price
    end
    (total_price_per_merchant / items_by_merchant.count).round(2)
  end

  def average_average_price_per_merchant
    @total_avgs ||= engine.merchants.all.reduce(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    (total_avgs / engine.merchants.all.count).floor(2)
  end

  def average_item_price
    @total_prices ||= engine.items.all.reduce(0) do |total, item|
      total + item.unit_price_to_dollars
    end
    (total_prices / engine.items.all.count).round(2)
  end

  def item_price_standard_deviation
    @price_set ||= engine.items.all.map do |item|
      item.unit_price_to_dollars
    end

    @price_squared_differences ||= price_set.map { |num| (num - average_item_price)**2 }
    (Math.sqrt( ( price_squared_differences.reduce(:+) ) / (price_set.count - 1) )).round(2)
  end

  def golden_items
    engine.items.all.select do |item|
      item.unit_price_to_dollars > (item_price_standard_deviation * 2 + average_item_price)
    end
  end

  def average_invoices_per_merchant
    (engine.invoices.all.count / engine.merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @invoice_set ||= engine.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    @invoices_squared_differences ||= invoice_set.map { |num| (num - average_invoices_per_merchant) ** 2 }

    (Math.sqrt( ( invoices_squared_differences.reduce(:+) ) / (invoice_set.count - 1) )).round(2)
  end

  def top_merchants_by_invoice_count
    engine.merchants.all.select do |merchant|
      merchant.invoices.count > (average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    engine.merchants.all.select do |merchant|
      merchant.invoices.count < (average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2)
    end
  end

  def invoices_by_day_average
    engine.invoices.all.count / 7
  end

  def invoices_by_day_standard_deviation
    invoices_by_day_squared_differences = invoices_by_day.values.map { |invoices| (invoices.count - invoices_by_day_average) ** 2 }
    (Math.sqrt( ( invoices_by_day_squared_differences.reduce(:+) ) / (invoices_by_day.values.count - 1) )).round(2)
  end

  def top_days_by_invoice_count
    @invoices_by_day ||= engine.invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end

    invoices_by_day.select { |day, invoices| invoices.count > (invoices_by_day_average + invoices_by_day_standard_deviation) }.keys
  end

  def invoice_status(status)
    ((engine.invoices.find_all_by_status(status).count / engine.invoices.all.count.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    @invoices_by_date ||= engine.invoices.all.select do |invoice|
      invoice.created_at == date
    end
    invoices_by_date.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def revenue_by_merchant(merch_id)
    engine.merchants.find_by_id(merch_id).revenue
  end

  def merchants_ranked_by_revenue
    @merchants_by_revenue ||= engine.merchants.all.sort_by do |merchant|
      [merchant.revenue ? 1 : 0, merchant.revenue]
    end.reverse
  end

  def top_revenue_earners(num_top = 20)
    merchants_ranked_by_revenue[0..num_top-1]
  end

  def merchants_with_pending_invoices
    @merchants_pending ||= engine.merchants.all.select do |merchant|
      merchant.any_pending?
    end
  end

  def merchants_with_only_one_item
    @merchants_one_item ||= engine.merchants.all.select do |merchant|
      merchant.only_one_item?
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end
  
  def invoices_that_are_paid_in_full_by_merchant(merchant_id)
    engine.invoices.find_all_by_merchant_id(merchant_id).select do |invoice|
      invoice.is_paid_in_full?
    end
  end
  
  def invoice_items_that_match_paid_in_full_merchant_invoices(merchant_id)
    items = [] 
    invoices = []
    engine.invoice_items.all.each do |invoice_item|
      if engine.merchants.find_by_id(merchant_id).items.any? {|item| item.id == invoice_item.item_id}
        items << engine.merchants.find_by_id(merchant_id).items.find {|item| item.id == invoice_item.item_id}
      end 
      if invoices_that_are_paid_in_full_by_merchant(merchant_id).any? {|invoice| invoice.id == invoice_item.invoice_id}
        invoices << invoices_that_are_paid_in_full_by_merchant(merchant_id).find {|invoice| invoice.id == invoice_item.invoice_id}
      end
    end
    
    engine.invoice_items.all.select do |invoice_item|
       items.any?{|item| invoice_item.item_id == item.id} && invoices.any?{|invoice| invoice_item.invoice_id == invoice.id}
    end
        
  end
  
  # def invoice_items_merchant_items_paid_in_full(merchant_id)
  #   engine.merchants.find_by_id(merchant_id).items.select do |item|
  #     invoice_items_merchant_items_paid_in_full(merchant_id).select do |invoice_item|
  #       invoice_item.item_id == item.id 
  #     end
  #   end  
  # end
  
  def most_sold_items(merchant_id)
    invoice_items_quantity = invoice_items_that_match_paid_in_full_merchant_invoices(merchant_id).inject(Hash.new(0)) do |memo, invoice_item|
      memo[invoice_item.quantity] = invoice_item
      memo
    end
    invoice_items_to_items = invoice_items_quantity.values.map do |value| 
      items.find_by_id(value.item_id)
    end
    
    invoice_items_quantity.keys.inject(Hash.new(0)) do |memo, quantity|
      invoice_items_to_items.each_with_index do |item, i|
        memo[quantity] = item[i]
        memo
      end
    end
    
    # invoice_items_that_match_paid_in_full_merchant_invoices(merchant_id).inject(Hash.new(0)) do |memo, invoice_item|
    #   invoice_items_to_items.each_with_index do |item, i|
    #     memo[invoice_item.quantity] = item[i]
    #   end
    # end
    invoice_items_to_items.group_by
  end
  
  def most_sold_item_for_merchant(merchant_id)
    arr = most_sold_items.max_by do |quantity, items|
      quantity
    end[1]
  end
  
  def most_sold_item_for_merchant(merchant_id)
    engine.merchants.find_by_id(merchant_id).most_sold_item
  end

end
