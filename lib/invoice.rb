# frozen_string_literal: true

# This class holds the data for each invoice.
class Invoice
  attr_reader :invoice_list,
              :parent
  def initialize(invoices_data, parent)
    @invoice_specs = {
      id:           invoices_data[:id].to_i,
      customer_id:  invoices_data[:customer_id].to_i,
      merchant_id:  invoices_data[:merchant_id].to_i,
      status:       invoices_data[:status],
      created_at:   invoices_data[:created_at],
      updated_at:   invoices_data[:updated_at]
    }
    @parent = parent
  end

  def id
    @invoice_specs[:id]
  end

  def customer_id
    @invoice_specs[:customer_id]
  end

  def merchant_id
    @invoice_specs[:merchant_id]
  end

  def status
    @invoice_specs[:status]
  end

  def created_at
    Time.parse(@invoice_spec[:created_at])
  end

  def updated_at
    Time.parse(@invoice_specs[:updated_at])
  end

  def merchant
    @parent.find_merchant_by_merchant_id(merchant_id)
  end
end
