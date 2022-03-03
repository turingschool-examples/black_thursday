require "pry"

class InvoiceRepository
  attr_reader :file_path, :invoices
  def initialize(file_path)
    @file_path = file_path
    @invoices = all
  end

  def all
    invoices = CSV.read(@file_path, headers: true, header_converters: :symbol)
    invoice_instances_array = []
    invoices.by_row!.each do |row|
      invoice_instances_array << Invoice.new(row)
    end
    invoice_instances_array
  end
  def find_by_id(id)
    invoices.find do |invoice_instance|
      invoice_instance.invoice_attributes[:id] == id
    end
  end

  def find_all_by_customer_id(id)
    invoices.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:customer_id] == id
    end
  end

  def find_all_by_merchant_id(id)
    invoices.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:merchant_id] == id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:status] == status
    end
  end

  def create(attributes)
    attributes[:id] = invoices[-1].invoice_attributes[:id] + 1
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    invoices << Invoice.new(attributes)
  end

  def update(id, attributes)
    attributes.each do |attribute|
      find_by_id(id).invoice_attributes[attribute[0]] = attribute[1]
    end
    find_by_id(id).invoice_attributes[:updated_at] = Time.now
  end

  def delete(id)
    invoices.delete(find_by_id(id))
  end
end
