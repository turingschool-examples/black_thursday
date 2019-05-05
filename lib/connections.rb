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

  def find_customers_by_merchant_id(merchant_id)
    all_ids = invoices.find_all_by_merchant_id(merchant_id).map(&:customer_id)
    all_ids.uniq.map { |customer_id| customers.find_by_id(customer_id) }
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    all_items = invoice_items.find_all_by_invoice_id(invoice_id).map(&:item_id)
    all_items.map { |item_id| items.find_by_id(item_id) }
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_all_invoices_by_customer_id(customer_id)
    invoices.find_all_by_customer_id(customer_id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end
end
