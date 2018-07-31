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
  
  # On which days are invoices created at more than one standard deviation above the mean?
  # sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]
  
  # def standard_deviation_of_invoices_by_day
  #   count = @invoice_repository.all.count
  #   avg = count / 7
  #   sum_differences_squared = arrange_invoices_by_day.inject(0) do |diff_squared, day_count|
  #     diff_squared += (day_count - avg) ** 2
  #   end
  #   Math.sqrt(sum_differences_squared/count) 
  # end 
  
  def arrange_invoices_by_day
    @invoice_repository.all.inject(Hash.new(0)) do |hash, invoice| 
      hash.merge(invoice.created_at.wday => hash[invoice.created_at.wday] + 1)
    end
  end 
end 