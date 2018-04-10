# frozen_string_literal: true

# This module is used to provide the methods that connect
# merchants and items through their parent classes, into
# the sales engine.
module Connections
  def find_all_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end
end
