require 'csv'
require './lib/sales_engine'
require './lib/invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(invoice_path)
    @all = (
      invoice_objects = []
      CSV.foreach(invoice_path, headers: true, header_converters: :symbol) do |row|
        invoice_objects << Invoice.new(row)
      end
      invoice_objects)
  end

  def find_by_id(id)
    if (@all.any? do |invoice|
      invoice.id == id
    end) == true
      @all.find do |invoice|
        invoice.id == id
      end
    else
      nil
    end
  end

  def find_all_by_customer_id(customer_id)
    if (@all.any? do |invoice|
      invoice.customer_id == customer_id
    end) == true
      @all.find_all do |invoice|
        invoice.customer_id == customer_id
      end
    else
      []
    end
  end

  def find_all_by_merchant_id(merchant_id)
    if (@all.any? do |invoice|
      invoice.merchant_id == merchant_id
    end) == true
      @all.find_all do |invoice|
        invoice.merchant_id == merchant_id
      end
    else
      []
    end
  end

  def find_all_by_status(status)
    if (@all.any? do |invoice|
      invoice.status == status
    end) == true
      @all.find_all do |invoice|
        invoice.status == status
      end
    else
      []
    end
  end

  def create(attributes)
    new_invoice = Invoice.new(attributes)
    @all << new_invoice
  end

  def update(id, attribute)
    if find_by_id(id) != nil
      (find_by_id(id).status.clear.gsub!("", attribute[:status]))
    end
  end
end
