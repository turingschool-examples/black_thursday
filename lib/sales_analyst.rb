require 'date'
require_relative 'business_intelligence'
require_relative 'customer_analytics'

class SalesAnalyst
  include BusinessIntelligence
  include CustomerAnalytics

  def initialize(parent)
    @parent = parent
  end

  def top_buyers(selected = 20)
    new_hash = customer_id_invoice_totals
    cust_ids_sorted_by_total = Hash[new_hash.sort_by { |_cust_id, total| total }]
    customer_ids = cust_ids_sorted_by_total.map { |cust_id, _total| cust_id }
    first_customer_ids = customer_ids.reverse.take(selected)
    first_customer_ids.map { |id| @parent.customers.find_by_id(id) }
  end

  def top_merchant_for_customer(customer_id)
    invoice_totals = invoice_totals_for_customer_id(customer_id)
    merchant_ids = merchant_ids_for_customer(customer_id)
    merch_totals = merchant_totals_per_customer(invoice_totals, merchant_ids)
    top_merch_id = merch_totals.max_by { |_id, total| total }[0]
    @parent.merchants.find_by_id(top_merch_id)
  end

  def one_time_buyers
    one_time_customer_ids.map { |cust_id| @parent.customers.find_by_id(cust_id) }
  end

  def one_time_buyers_top_item
    paid_one_time_invoices = delete_unpaid(one_time_invoices)
    invoice_items = paid_one_time_invoices.map do |invoice|
      @parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    @parent.items.find_by_id(max_quantity_invoice_item_id(invoice_items))
  end

  def items_bought_in_year(customer_id, year)
    invoice_items = invoice_items_for_year(customer_id, year)
    item_ids_for_year = invoice_items.map do |invoice_item|
      invoice_item.item_id
    end.uniq
    item_ids_for_year.map { |item_id| @parent.items.find_by_id(item_id) }
  end

  def highest_volume_items(customer_id)
    invoice_items = invoice_items_from_customer_id(customer_id)
    quantity_per_item = quantity_per_invoice_item(invoice_items)
    sorted_items = quantity_per_item.sort_by { |_item_id, quantity| quantity }
    highest_quantity = sorted_items[-1][1]
    find_items_with_highest_quantity(highest_quantity, quantity_per_item)
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = @parent.invoices.all.find_all do |invoice|
      !invoice_paid_in_full?(invoice.id)
    end
    unpaid_cust_ids = unpaid_invoices.map { |invoice| invoice.customer_id }
    unpaid_cust_ids.map { |cust_id| @parent.customers.find_by_id(cust_id) }.uniq
  end

  def best_invoice_by_revenue
    paid_invoices = delete_unpaid(@parent.invoices.all)
    invoice_items = invoice_items_for_invoices(paid_invoices)
    invoice_ids_and_totals = invoice_ids_and_totals(invoice_items)
    best_invoice_id = invoice_ids_and_totals.max_by { |_inv_id, total| total }[0]
    @parent.invoices.find_by_id(best_invoice_id)
  end

  def best_invoice_by_quantity
    paid_invoices = delete_unpaid(@parent.invoices.all)
    invoice_items = invoice_items_for_invoices(paid_invoices)
    invoice_ids_and_quants = invoice_ids_and_quantities(invoice_items)
    best_invoice_id = invoice_ids_and_quants.max_by { |_inv_id, total| total }[0]
    @parent.invoices.find_by_id(best_invoice_id)
  end
end
