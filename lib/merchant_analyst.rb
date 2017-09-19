require 'pry'
module MerchantAnalyst

  def calculate_total_revenue(invoice_list)
    invoice_list.reduce(0) do |total_revenue, invoice|
      total_revenue + invoice.total
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date = @engine.invoices.find_all_by_date(date)
    calculate_total_revenue(invoices_by_date)
  end

  def revenue_per_merchant(merchant_id)
    merchant_invoices = @engine.invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoice_revenues = merchant_invoices.map do |merchant_invoice|
      merchant_invoice.total
    end
    merchant_invoice_revenues.compact.sum
  end

  def total_revenue_for_all_merchants
    revenue_per_invoice = Hash[@engine.invoice_list.map {|invoice| [invoice.merchant_id, revenue_per_merchant(invoice.merchant_id)]}]
  end

  def top_revenue_earners(x)
    all_earners_sorted = total_revenue_for_all_merchants.sort_by {|key, value| value}.to_h
    top_x_earner_ids = all_earners_sorted.keys[-x..-1]
    top_x_earner_ids.map {|earner_id| @engine.merchants.find_by_id(earner_id)}
  end

  def merchants_with_pending_invoices
    pending_invoices = @engine.invoice_list.find_all do |invoice|
      invoice.status == :pending
    end

    pending_merchant_ids = pending_invoices.map do |invoice|
      invoice.merchant_id
    end
    pending_merchant_ids.uniq.map do |merchant_id|
      @engine.merchants.find_by_id(merchant_id)
    end
  end

   def collect_item_merchant_ids
     item_merchant_ids = @engine.item_list.map do |item|
       item.merchant_id
     end
   end

  def find_merchant_ids_with_only_one_item
    item_merchant_ids = collect_item_merchant_ids
    one_item_merchant_ids = []

    item_merchant_ids.each do |merchant_id|
      if item_merchant_ids.count(merchant_id) == 1
        one_item_merchant_ids << merchant_id
      end
    end
    one_item_merchant_ids
  end

  def merchants_with_only_one_item
    one_item_merchant_ids = find_merchant_ids_with_only_one_item

    one_item_merchant_ids.map do |merchant_id|
      @engine.merchants.find_by_id(merchant_id)
    end
  end

end
