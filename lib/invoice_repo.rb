require 'pry'
require 'invoice'

class InvoiceRepository
  attr_reader :invoice_instance_array
  def initialize(invoice_instance_array)
    @invoice_instance_array = invoice_instance_array
  end

  def all
    invoice_instance_array
  end

  def find_by_id(id)
    invoice_instance_array.find do |invoice_instance|
      invoice_instance.invoice_attributes[:id] == id
    end
  end

  def find_all_by_customer_id(id)
    invoice_instance_array.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:customer_id] == id
    end
  end

  def find_all_by_merchant_id(id)
    invoice_instance_array.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:merchant_id] == id
    end
  end

  def find_all_by_status(status)
    invoice_instance_array.find_all do |invoice_instance|
      invoice_instance.invoice_attributes[:status] == status
    end
  end

  def create(attributes)
    attributes[:id] = invoice_instance_array[-1].invoice_attributes[:id] + 1
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    invoice_instance_array << Invoice.new(attributes)
  end
end
