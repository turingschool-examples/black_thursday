# frozen_string_literal: true

# This is an InvoiceRepository class for Black Friday

require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(invoice_data)
    @all = fill_invoices(invoice_data)
  end

  def fill_invoices(invoice_data)
    all_invoices = CSV.parse(File.read(invoice_data))
    categories = all_invoices.shift
    all_invoices.map do |invoice|
      individual_invoice = {}
      categories.zip(invoice) do |category, attribute|
        individual_invoice[category.to_sym] = attribute
      end
      Invoice.new(individual_invoice)
    end
  end

  def find_by_id(id)
    all.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    creation_time = Time.now.to_s
    all << Invoice.new(
      id: final_invoice.id.to_i + 1,
      customer_id: attributes[:customer_id],
      merchant_id: attributes[:merchant_id],
      status: attributes[:status],
      created_at: creation_time,
      updated_at: creation_time
    )
  end

  def final_invoice
    all.max_by(&:id)
  end

  def update(id, attribute)
    attribute.each do |key, value|
      find_by_id(id).update(key, value)
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
