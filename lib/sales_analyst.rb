require_relative './sales_engine'

class SalesAnalyst
  attr_reader       :sales_engine,
                    :item_repository, :merchant_repository, :merchant_id_item_counts,
                    :item_count_std_dev,
                    :invoice_repository,
                    :merchant_id_invoice_counts,
                    :merchant_id_invoice_counts_std_dev

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repository = @sales_engine.items
    @merchant_repository = @sales_engine.merchants
    @invoice_repository = @sales_engine.invoices
    @merchant_id_item_counts = nil
    @item_count_std_dev = nil
    @merchant_id_invoice_counts = nil
    @merchant_id_invoice_counts_std_dev = nil
  end

  def average_items_per_merchant_standard_deviation
    @item_count_std_dev =
    (Math.sqrt(sum_of_differences_squared / @merchant_repository.all.count)).round(2)
  end

  # helper to average_items_per_merchant_standard_deviation
  def sum_of_differences_squared
    merchant_id_item_counter
    avg = average_items_per_merchant
    counts = @merchant_id_item_counts
    sum = 0.00
    @merchant_repository.all.each do |merchant|
      sum += (counts[merchant.id].to_f - avg.to_f)**2
    end
    return sum.round(2)
  end

  # helper to sum_of_differences_squared
  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  # helper to sum_of_differences_squared
  def merchant_id_item_counter
    m_item_count = Hash.new(0)
    sales_engine.merchants.all.map do |merchant|
      m_items = sales_engine.items.all.find_all do |item|
        item.merchant_id == merchant.id
        # m_items
      end
      m_item_count[merchant.id] += m_items.count
    end
    @merchant_id_item_counts = m_item_count
  end

  def merchants_with_high_item_count
    ids_with_high_item_count.map do |id_array|
      @merchant_repository.all.find do |merchant|
        merchant.id == id_array[0]
      end
    end
  end

  # helper to merchants_with_high_item_count
  def ids_with_high_item_count
    merchant_id_item_counter
    average_items_per_merchant_standard_deviation
    id_high_items = @merchant_id_item_counts.find_all do |id, count|
      count > @item_count_std_dev + average_items_per_merchant
    end
    return id_high_items
  end

  def average_average_price_per_merchant
    sum = create_array_of_averages_per_merchant.inject(0) do |total, avg|
      total += avg
    end
    count = create_array_of_averages_per_merchant.count
    (sum / count).round(2)
  end

  # helper to average_average_price_per_merchant
  def create_array_of_averages_per_merchant
    @merchant_repository.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  # => BigDecimal
  def average_item_price_for_merchant(merchant_id)
    price_array = create_price_array(merchant_id)
    sum = sum_prices_in_price_array(price_array)
    if price_array.count > 0
    (sum / price_array.count).round(2)
    end
  end

  # helper to average_item_price_for_merchant
  def create_price_array(merchant_id)
    find_items_by_merchant_id(merchant_id).map! do |item_object|
      item_object.unit_price
    end
  end

  # helper to create_price_array
  def find_items_by_merchant_id(merchant_id)
    @item_repository.all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  # helper to average_item_price_for_merchant
  def sum_prices_in_price_array(price_array)
    price_array.inject(0) do |total, price|
      total += price
    end
  end

  # golden_items => array of items 2 std dev above avg price
  def golden_items
    std_dev_doubled = price_standard_deviation * 2
    @item_repository.all.find_all do |item|
      item.unit_price > std_dev_doubled
    end
  end

  def price_standard_deviation
    (Math.sqrt(sum_of_price_differences_squared / @item_repository.all.count)).round(2)
  end

  # helper to price_standard_deviation
  def sum_of_price_differences_squared
    avg_price = average_item_price
    sum = @item_repository.all.inject(0) do |total, item_object|
      total += (item_object.unit_price - avg_price) ** 2
    end
    return sum.round(2)
  end

  def average_item_price
    sum = @item_repository.all.inject(0) do |total, item_object|
      total += item_object.unit_price
    end
    count = @item_repository.all.count
    (sum / count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation # => 3.29
    @merchant_id_invoice_counts_std_dev =
    (Math.sqrt(sum_of_inv_differences_squared / @merchant_repository.all.count)).round(2)
  end

  # helper to average_invoices_per_merchant_standard_deviation
  def sum_of_inv_differences_squared
    merchant_id_invoice_counter
    avg = average_invoices_per_merchant
    counts = @merchant_id_invoice_counts
    sum = 0.00
    @merchant_repository.all.each do |merchant|
      sum += (counts[merchant.id].to_f - avg.to_f)**2
    end
    return sum.round(2)
  end

  # helper to sum_of_inv_differences_squared
  def merchant_id_invoice_counter
    m_invoice_count = Hash.new(0)
    @merchant_repository.all.map do |merchant|
      m_invoices = @invoice_repository.all.find_all do |invoice|
        invoice.merchant_id == merchant.id
        # m_items
      end
      m_invoice_count[merchant.id] += m_invoices.count
    end
    @merchant_id_invoice_counts = m_invoice_count
  end

  # helper to sum_of_inv_differences_squared
  def average_invoices_per_merchant
    (@invoice_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def top_merchants_by_invoice_count
    ids_with_high_invoice_count.map do |id_array|
      @merchant_repository.all.find do |merchant|
        merchant.id == id_array[0]
      end
    end
  end

  # helper to top_merchants_by_invoice_count
  def ids_with_high_invoice_count
    merchant_id_invoice_counter
    average_invoices_per_merchant_standard_deviation
    id_high_invoices = @merchant_id_invoice_counts.find_all do |id, count|
      count > ((@merchant_id_invoice_counts_std_dev) * 2) + average_invoices_per_merchant
    end
    return id_high_invoices
  end

  def bottom_merchants_by_invoice_count
    ids_with_low_invoice_count.map do |id_array|
      @merchant_repository.all.find do |merchant|
        merchant.id == id_array[0]
      end
    end
  end

  # helper to bottom_merchants_by_invoice_count
  def ids_with_low_invoice_count
    merchant_id_invoice_counter
    average_invoices_per_merchant_standard_deviation
    id_low_invoices = @merchant_id_invoice_counts.find_all do |id, count|
      count < average_invoices_per_merchant - ((@merchant_id_invoice_counts_std_dev) * 2)
    end
    return id_low_invoices
  end

  def top_days_by_invoice_count
    day_names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    top_integer_days_by_invoice_count.map do |element| 
      day_names[element[0]]
    end 
  end 
  
  # helper to top_days_by_invoice_count
  # returns nested array 
  def top_integer_days_by_invoice_count 
    count = @invoice_repository.all.count
    avg = count / 7
    arrange_invoices_by_day.find_all do |day, day_count|
      day_count > (avg + standard_deviation_of_invoices_by_day).round(0)
    end
  end
  
  # helper to top_days_by_invoice_count
  def standard_deviation_of_invoices_by_day
    count = (@invoice_repository.all.count) -1
    avg = count / 7
    sum_differences_squared = arrange_invoices_by_day.inject(0) do |diff_squared, day_count|
      diff_squared += (day_count[1] - avg) ** 2
    end
    # binding.pry 
    (Math.sqrt(sum_differences_squared/7)).round(3)
  end 
  
  # helper to standard_deviation_of_invoices_by_day
  def arrange_invoices_by_day
    @invoice_repository.all.inject(Hash.new(0)) do |hash, invoice|
      hash.merge(invoice.created_at.wday => hash[invoice.created_at.wday] + 1)
    end

  end 
  
  def invoice_status(inv_symbol)
    ((@invoice_repository.all.find_all do |invoice_obj|
      invoice_obj.status == inv_symbol
    end.count / @invoice_repository.all.count.to_f) * 100).round(2)
  end 
  
  def invoice_paid_in_full?(invoice_id)
    return false if @sales_engine.transactions.find_all_by_invoice_id(invoice_id) == []
      invoice = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    invoice.all? do |invoice|
      invoice.result == :success
    end
 end
 
  def invoice_total(invoice_id)
    invoice_items_by_invoice_id(invoice_id).inject(BigDecimal(0)) do |total, object|
      total += (object.unit_price_to_dollars * object.quantity)
    end
  end 
  
  # helper to invoice_total
  def invoice_items_by_invoice_id(invoice_id)
    @sales_engine.invoice_items.all.find_all do |inv_item| 
      inv_item.invoice_id == invoice_id
    end 
  end
  
  def total_revenue_by_date(date)
    invoices_by_date(date).inject(BigDecimal(0)) do |total, invoice|
      if invoice_paid_in_full?(invoice.id) == true 
       total += invoice_total(invoice.id)
     end
    end 
  end
  
  #helper to total_revenue_by_date
  def invoices_by_date(date)
    @sales_engine.invoices.all.find_all do |inv_item| 
      inv_item.created_at.strftime("%F") == date.strftime("%F")
    end
  end
  
  def merchants_with_only_one_item 
    merchant_ids_with_only_one_item.map do |merch_id|
      @merchant_repository.all.reject do |merchant|
        merchant.id != merch_id 
      end 
    end.flatten      
  end 
  
  # helper to merchants_with_only_one_item
  def merchant_ids_with_only_one_item 
    merchant_id_item_counter.reject do |merch_id, count|
      count != 1
    end.keys
  end 
  
  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end 
  
  def merchants_ranked_by_revenue 
    # revenue_by_merchant.sort_by do |merch_id, revenue|
    #    
    # end
  end
  
  def merchant_id_revenue_hash 
    @merchant_repository.all.inject(Hash.new(0)) do |hash, merchant|
      hash.merge(merchant.id => revenue_by_merchant(merchant.id))
    end
  end
  
  def revenue_by_merchant(merchant_id)
    revenue_hash_by_merchant_id(merchant_id)[merchant_id]
  end
  
  def revenue_hash_by_merchant_id(merchant_id)
    find_all_invoices_paid_in_full.inject(Hash.new(BigDecimal(0))) do |hash, invoice|
      hash.merge(invoice.merchant_id => hash[invoice.merchant_id] += invoice_total(invoice.id))
    end
  end

  def find_all_invoices_paid_in_full
    @sales_engine.invoices.all.find_all do |inv|
      invoice_paid_in_full?(inv.id) == true 
    end 
  end 
end
