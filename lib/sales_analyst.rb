require_relative 'helper_methods'

class SalesAnalyst
  include HelperMethods
  attr_reader :items, :merchants, :engine

  def initialize(item_repo, merchant_repo, engine)
    @items = item_repo
    @merchants = merchant_repo
    @engine = engine
  end

  def group_items_by_merchant_id
    @items.all.group_by do |item|
      item.merchant_id
    end
  end

  def average_items_per_merchant
    grouping = group_items_by_merchant_id
    total = group_items_by_merchant_id.values.sum do |items_array|
      items_array.length
    end
    (total / grouping.values.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    grouping = group_items_by_merchant_id
    average = average_items_per_merchant
    result = grouping.values.reduce(0) do |total, array_length|
      total + ((array_length.length - average)**2)
    end
    (Math.sqrt(result/grouping.values.length.to_f - 1)).round(2)
  end

  def merchants_with_high_item_count
    # do stuff
  end

  def average_item_price_for_merchant(merchant_id)
    # do stuff
  end

  def average_average_price_per_merchant
    # do stuff
  end

  def golden_items
    # do stuff
  end

  def average_invoices_per_merchant
    # do stuff
  end

  def average_invoices_per_merchant_standard_deviation
    # do stuff
  end

  def top_merchants_by_invoice_count
    # do stuff
  end

  def bottom_merchants_by_invoice_count
    # do stuff
  end

  def top_days_by_invoice_count
    # do stuff
  end

  def invoice_status
    # do stuff
  end

end
