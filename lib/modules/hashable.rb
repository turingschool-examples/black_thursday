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

  def revenue_by_invoice_hash
    revenue_invoice = {}
    invoice_id_with_successful_payments.map do |id|
      revenue_invoice[id] = @engine.invoice_items.find_revenue_by_invoice_id(id)
    end
    revenue_invoice
  end

  def month_name_to_number_hash
    month_to_num = {
                      'January' => 1,
                      'February' => 2,
                      'March'=> 3,
                      'April' => 4,
                      'May' => 5,
                      'June' => 6,
                      'July' => 7,
                      'August' => 8,
                      'September' => 9,
                      'October' => 10,
                      'November' => 12,
                      'December' => 12
                    }
  end

  def invoice_id_by_merchant_id_hash
    merchid_invid = Hash.new { |hash, key| hash[key] = []}
    merch_invoices_hash.each do |merchant, invoices|
      invoices.map do |invoice|
        merchid_invid[merchant] << invoice.id
      end
    end
    merchid_invid
  end

  def revenue_by_merchant_id_hash
    merch_revenue = {}
    invoice_id_by_merchant_id_hash.each do |merchant, invoices|
      merch_revenue[merchant] = invoices.sum do |inv|
        revenue_by_invoice_hash[inv]
      end
    end
    merch_revenue
  end
end
