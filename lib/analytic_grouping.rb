# frozen_string_literal: false

# Responsible for storing grouped data for optimization
module AnalyticGrouping
  def items_group_by_merchant_id
    @items_group_by_merchant_id ||= @items.all.group_by(&:merchant_id)
  end

  def invoices_group_by_merchant_id
    @invoices_group_by_merchant_id ||= @invoices.all.group_by(&:merchant_id)
  end

  def invoices_group_by_customer_id
    @invoices_group_by_customer_id ||= @invoices.all.group_by(&:customer_id)
  end

  def invoices_group_by_status
    @invoices_group_by_status ||= @invoices.all.group_by(&:status)
  end

  def invoice_items_group_by_invoice_id
    @invoice_items_group_by_invoice_id ||=
      @invoice_items.all.group_by(&:invoice_id)
  end
end
