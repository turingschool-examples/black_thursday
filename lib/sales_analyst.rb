require './lib/sales_engine'
class SalesAnalyst
  attr_reader :item_repository, :merchant_repository, :invoice_repository

  def initialize(item_repository, merchant_repository, invoice_repository)
    #delete merchant_repository from this and sales engine if we end up not using
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
    @merchant_invoices = {}
  end

  def merchant_items_hash
    items_hash = @item_repository.all.group_by {|item| item.merchant_id}
    items_hash.map {|keys, values| items_hash[keys] = values.count}
    items_hash
  end

  def average_items_per_merchant
    number_of_merchants = merchant_items_hash.keys.count
    total_number_of_items = merchant_items_hash.values.sum
    average = (total_number_of_items.to_f / number_of_merchants)
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    diff_squared = merchant_items_hash.values.map {|item_count| (item_count-average_items_per_merchant)**2}
    std_dev = (diff_squared.sum / (diff_squared.count.to_f - 1))**0.5
    std_dev.round(2)
  end

  def merchants_with_high_item_count
    one_std_dev = average_items_per_merchant + average_items_per_merchant_standard_deviation
    top_merchants = merchant_items_hash.find_all {|keys, values| values > one_std_dev}
    top_merchant_array = top_merchants.map do |merchant|
      @merchant_repository.find_by_id(merchant[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @item_repository.all.find_all {|item| merchant_id == item.merchant_id}
    merchant_items = merchant_items.map {|item| item.unit_price}
    average = merchant_items.sum / merchant_items.count
  end

  def average_average_price_per_merchant
    merchants = merchant_items_hash.keys
    average = merchants.map {|merchant| average_item_price_for_merchant(merchant)}
    average_average = average.sum / average.count
  end

  def average_price_plus_two_standard_deviations
    prices = @item_repository.all.map {|item| item.unit_price}
    average = prices.sum / prices.count
    diff_squared = prices.map {|price| (price-average)**2}
    std_dev = (diff_squared.sum / (diff_squared.count.to_f - 1))**0.5
    avg_plus_two_std_dev = average + 2 * std_dev
  end

  def golden_items
    top_items = @item_repository.all.find_all {|item| item.unit_price > average_price_plus_two_standard_deviations}
    top_items
  end

  def average_invoices_per_merchant
    number_of_merchants = merchant_items_hash.keys.count
    total_number_of_invoices = @invoice_repository.all.count
    average = (total_number_of_invoices.to_f / number_of_merchants)
    average.round(2)
  end

  def invoices_per_merchant
    @merchant_repository.all.map do |merchant|
      invoices = @invoice_repository.all.find_all do |invoice|
        invoice.merchant_id == merchant.id
      end
      @merchant_invoices[merchant.id] = invoices.count
    end
    @merchant_invoices
  end

  def average_invoices_per_merchant_standard_deviation
    diff_squared = invoices_per_merchant.values.map do |item_count|
      (item_count-average_invoices_per_merchant)**2
    end
    std_dev = (diff_squared.sum / (diff_squared.count.to_f - 1))**0.5
    std_dev.round(2)
  end

end
