module Hashable
  def merch_items_hash
    merch_items = {}
    @engine.merchants.all.map do |merchant|
      merch_items[merchant] = @engine.items.find_all_by_merchant_id(merchant.id)
    end
    merch_items
  end

  def merch_invoices_hash
    merch_invoices = {}
    @engine.merchants.all.map do |merchant|
      merch_invoices[merchant] = @engine.invoices.find_all_by_merchant_id(merchant.id)
    end
    merch_invoices
  end

  def revenue_by_invoice_hash
    revenue_invoice = {}
    @engine.invoices.all.map do |invoice|
      if invoice_paid_in_full?(invoice.id) == false
        revenue_invoice[invoice] = 0.0
      else
        revenue_invoice[invoice] = @engine.invoice_items.find_revenue_by_invoice_id(invoice.id)
      end
    end
    revenue_invoice
  end

  def revenue_by_merchant_hash
    merchant_revenue = Hash.new(0)
    new = revenue_by_invoice_hash.to_a.map do |hash|
      hash[0] = @engine.merchants.find_by_id(hash[0].merchant_id), hash[1]
    end
    new.map do |merchant, revenue|
      merchant_revenue[merchant] += revenue
    end
    merchant_revenue
  end

  def merchants_with_one_item_hash
    merch_items_hash.select do |merch, item|
      item.length == 1
    end
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
end
