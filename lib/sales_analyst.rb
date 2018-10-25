require_relative 'statistics'
class SalesAnalyst
  attr_reader :items, :merchants, :invoices
  include Statistics
  def initialize(items, merchants, invoices = nil)
    @items = items
    @merchants = merchants
    @invoices = invoices
  end
  # TYPES = %w(item merchant invoice)
  # TYPES.permutation(2) do |type_1, type_2|
    # require 'pry'; binding.pry
    # type_1s = type_1 + 's'; type_2s = type_2 + 's'
    # type_1_repos
    # average_name = "average_#{type_1s}_per_#{type_2}".to_sym
    # define_method(average_name) do
    #   (type_1.all.size.to_f / type_2.all.size).round(2)
    # end
    # standard_deviation_name = "average_#{type_1s}_per_#{type_2}_standard_deviation"
    # # define_method(standard_deviation_name) do
    #   array_of_amounts = s
    # end
  # end




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
      num_items_of_merchant(merchant) > temp_sd + average_items_per_merchant
    end
  end
  def top_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_items_of_merchant(merchant) > temp_sd + average_items_per_merchant
    end
  end
  def bottom_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_items_of_merchant(merchant) < average_items_per_merchant - temp_sd
    end
  end



  def average_item_price_for_merchant(merchant_id)
    prices = @items.find_all_by_merchant_id(merchant_id).map(&:unit_price)
    average(*prices).to_f.round(2)
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
end
