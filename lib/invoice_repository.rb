require_relative './invoice'
require 'pry'
class InvoiceRepository
  attr_reader :invoices_array
  def initialize(file_path)
    @invoices_array = invoice_csv_converter(file_path)
  end

  def invoice_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:invoice_id] = obj[:invoice_id].to_i
      obj[:merchant_id] = obj[:merchant_id].to_i
      obj[:status] = obj[:status].to_sym
      obj[:customer_id] = obj[:customer_id].to_i
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      Invoice.new(obj.to_h)
    end
  end

  def inspect
    "#<#{self.class} #{@invoices_array.size} rows>"
  end

  def all
    @invoices_array
  end

  def find_by_id(id)
    findings = @invoices_array.find_all do |invoice|
      invoice.id == id
    end
    findings[0]
  end

  def find_all_by_merchant_id(merchant_id)
    findings = @invoices_array.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices_array.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    findings = @invoices_array.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    last_invoice = @invoices_array.last
    if last_invoice == nil
      max_id = 1
    else
      max_id = last_invoice.id + 1
    end
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :name => attributes[:name],
                  :description => attributes[:description],
                  :unit_price => attributes[:unit_price],
                  :merchant_id => attributes[:merchant_id],
                  :created_at => time,
                  :updated_at => time }
    @invoices_array << Invoice.new(attributes)
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    if attribute[:status].class == Symbol
      invoice.updated_at = Time.now
      invoice.status = attribute[:status]
    else
      'You can not modify this attribute'
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    if merchant != nil
      index = @invoices_array.index(merchant)
      @invoices_array.delete_at(index)
    else
      puts "Item not found"
    end
  end
end
