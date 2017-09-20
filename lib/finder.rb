require_relative "sales_engine"

module Finder

  def merchants_for_month(month)
    sales_engine.merchants.merchants_registered_in_month(month)
  end

  def merchant_invoices(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id).invoices
  end

  def merchants
    sales_engine.merchants.all
  end

  def invoices
    sales_engine.invoices.all
  end

  def invoice_repo
    sales_engine.invoices
  end

  def item_repo
    sales_engine.items
  end

  def merchant_repo
    sales_engine.merchants
  end

end
