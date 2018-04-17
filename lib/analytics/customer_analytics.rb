# Module for methods concerning customer analytics
module CustomerAnalytics
  def top_buyers(amount_of_buyers = 20)
    top_buyers_by_id = []
    totals = sort_totals
    amount_of_buyers.times do
      top_buyers_by_id << totals.shift.shift
    end
    top_buyers = top_buyers_by_id.map do |buyer|
      @customer_repo.find_by_id(buyer)
    end
    top_buyers
  end

  def top_merchant_for_customer(customer_id)
    invoices = invoices_per_customer[customer_id]
    invoices_by_total_items = invoices.group_by do |invoice|
      total_invoice_items(invoice.id)
    end
    most_items = invoices_by_total_items.keys.max
    top_invoice = invoices_by_total_items.values_at(most_items).flatten.shift
    @merchant_repo.find_by_id(top_invoice.merchant_id)
  end

  def one_time_buyers_invoice_items
    single_invoices = invoices_per_customer.select do |customer_id, invoices|
      invoices.length == 1
    end
    invoices = single_invoices.values.flatten
    invoices.flat_map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end
  end

  def one_time_buyers_top_item_quantity
    invoice_items = one_time_buyers_invoice_items
    item_id_by_inv_items = invoice_items.group_by(&:item_id)
    quantities = item_id_by_inv_items.values.map do |value|
      value.map(&:quantity).reduce(:+)
    end
    quantities.sort.last
  end

  def one_time_buyers_top_item
    # invoice_items = one_time_buyers_invoice_items
    # item_ids = invoice_items.map(&:item_id).uniq
    # top_quantity = one_time_buyers_top_item_quantity
    # require "pry";binding.pry
    #
    # top_items.map do |invoice_item|
    #   @item_repo.find_by_id(invoice_item.item_id)
    # end
  end

  def customers_with_unpaid_invoices
    customer_invoice_ids = invoices_per_customer
    unpaid_invoices_by_customer = {}
    customer_invoice_ids.each do |customer_id, invoices|
      unpaid_invoices = invoices.find_all do |invoice|
        invoice unless invoice_paid_in_full?(invoice.id)
      end
      unpaid_invoices_by_customer[customer_id] = unpaid_invoices
    end

    unpaid_invoices_by_customer.delete_if do |customer_id, invoice_results|
      invoice_results.empty?
    end

    customer_ids = unpaid_invoices_by_customer.keys
    customer_ids.map do |id|
      @customer_repo.find_by_id(id)
    end
  end
end
