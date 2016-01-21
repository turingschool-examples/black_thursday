module MerchantAnalysis
  def top_revenue_earners(merchants = 20)
    earners_with_rev.to_h.keys[0,merchants]
  end

  def earners_with_rev
    sort_earners.reject {|k,v| v.to_f == 0.0}
  end

  def sort_earners
    merchant_and_total_rev_array.to_h.sort_by{|k,v| -v}
  end

  def merchant_and_total_rev_array
    se.merchants.all.map do |merchant|
      [merchant, merchant.total_revenue]
    end
  end

  def merchants_ranked_by_revenue
    earners_with_rev.to_h.keys
  end
# ========================================================
  #
  def merchants_with_pending_invoices
    se.merchants.all.find_all do |merchant|
      merchant.invoice_status_pending
    end

  end

  def merchants_with_only_one_item
    se.merchants.all.find_all do |merchant|
      merchant.merchant_with_one_item
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    sort_earners.to_h[merchant]
  end

  # ==============================================================
  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end
end
