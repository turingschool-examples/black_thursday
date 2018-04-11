# frozen_string_literal: true

require_relative 'invoice.rb'
# This is the invoice repository.
class InvoiceRepository
  def initialize(invoices, parent)
    @invoice_list = invoices.map { |invoice| Invoice.new(invoice, self) }
    @parent = parent
  end

  def find_by_id(id)
    @invoice_list.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(cust_id)
    @invoice_list.find_all { |invoice| invoice.customer_id == cust_id }
  end

  def all
    @invoice_list
  end

  def find_all_by_status(invoice_status)
    @invoice_list.find_all do |invoice|
      invoice.status == invoice_status
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoice_list.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def create(attributes)
    id_array = @invoice_list.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @invoice_list << Invoice.new(attributes, self)
  end

  def delete(id)
    invoice_to_delete = find_by_id(id)
    @invoice_list.delete(invoice_to_delete)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    unchangeable_keys = %i[id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if invoice.invoice_specs.keys.include?(key)
        invoice.invoice_specs[key] = value
        invoice.invoice_specs[:updated_at] = Time.now
      end
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    @parent.find_transaction_by_invoice_id(invoice_id)
  end

  def find_all_items_by_merchant_id(merchant_id)
    @parent.find_all_items_by_merchant_id(merchant_id)
  end

  def find_customer_by_customer_id(customer_id)
    @parent.find_customer_by_customer_id(customer_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    @parent.find_all_items_by_invoice_id(invoice_id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    @parent.find_all_invoice_items_by_invoice_id(id)
  end

  def inspect
    "<#{self.class} #{@invoice_list.size} rows>"
  end
end
