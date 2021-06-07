module Hashable
  def merch_items_hash
    merch_items = {}
    @engine.merchants.all.map do |merchant|
      merch_items[merchant.id] = @engine.items.find_all_by_merchant_id(merchant.id)
    end
    merch_items
  end

  def merch_invoices_hash
    merch_invoices = {}
    @engine.merchants.all.map do |merchant|
      merch_invoices[merchant.id] = @engine.invoices.find_all_by_merchant_id(merchant.id)
    end
    merch_invoices
  end

  def days_invoices_hash
    days_invoices = {
                     'Sunday'    => pull_day_from_invoice.count(0),
                     'Monday'    => pull_day_from_invoice.count(1),
                     'Tuesday'   => pull_day_from_invoice.count(2),
                     'Wednesday' => pull_day_from_invoice.count(3),
                     'Thursday'  => pull_day_from_invoice.count(4),
                     'Friday'    => pull_day_from_invoice.count(5),
                     'Saturday'  => pull_day_from_invoice.count(6),
                  }
  end

  def revenue_by_invoice
    revenue_invoice = {}
    invoice_id_with_successful_payments.map do |id|
      revenue_invoice[id] = @engine.invoice_items.find_revenue_by_invoice_id(id)
    end
    revenue_invoice
  end
end
