class SalesAnalyst

  def initialize(items, merchants, invoices)
    @items              = items
    @merchants          = merchants
    @invoices           = invoices
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

  
end
