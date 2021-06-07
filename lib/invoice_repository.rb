require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoice(path)
  end

  def create_invoice(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |invoice|
    @all << Invoice.new(invoice, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.select do |invoice|
      invoice.status == status
    end
  end

  def next_highest_id
    @all.max_by do |invoice|
      invoice.id
    end.id + 1
  end

  def create(attributes)
    new_invoice = Invoice.create_new(attributes, self)
    @all << new_invoice
  end

  def update(id, attributes)
    unless find_by_id(id).nil?
      find_by_id(id).update_invoice(attributes)
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def group_invoices_by_merchant
    @all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def invoices_per_merchant
    merchants = group_invoices_by_merchant
    merchants.each do |merchant, invoice|
      merchants[merchant] = invoice.length
    end
    merchants
  end

  def invoice_status(status)
    @all.select do |invoice|
      invoice.status == status
    end.count / @all.count.to_f * 100
    round(2)
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  # :nocov:

end
