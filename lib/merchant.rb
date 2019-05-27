require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name,
              :month_registered

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @month_registered = Time.parse(data[:created_at]).strftime('%B').downcase
    @merchant_repository = parent
  end

  def items
    @merchant_repository.find_items_by_id(@id)
  end

  def average_item_price
    sum_prices = items.sum do |item|
      item.unit_price
    end
    return (sum_prices / items.count).round(2)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end.uniq
  end

  def invoices
    @merchant_repository.find_invoices_by_id(@id)
  end

  def paid_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def revenue
    paid_invoices.sum do |invoice|
      invoice.total
    end
  end

  def pending_invoices?
    invoices.any? do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def paid_invoice_items
    paid_invoices.map(&:invoice_items).flatten
  end

  def all_item_ids
    paid_invoice_items.map(&:all_items).flatten
  end

  def grouped_item_ids
    all_item_ids.group_by do |item_id|
      item_id
    end
  end

  def item_ids_by_amount_sold
    grouped_item_ids.transform_values do |item_ids|
      item_ids.count
    end
  end

  def item_ids_by_total_cost
    ids_by_cost = {}
    paid_invoice_items.each do |invoice_item|
      ids_by_cost[invoice_item.item_id] = invoice_item.total_cost
    end
    return ids_by_cost
  end

  def item_ids_by_revenue
    item_ids_by_total_cost.merge(item_ids_by_amount_sold) do |id, cost, amount|
      cost * amount
    end
  end

  def best_item_id
    max_revenue = item_ids_by_revenue.values.max
    item_ids_by_revenue.key(max_revenue)
  end

  def most_sold
    item_ids_by_amount_sold.values.max
  end

  def most_sold_item_ids
    grouped_item_ids.keep_if do |item_id, item_ids|
      item_ids.count == most_sold
    end.keys
  end
end
