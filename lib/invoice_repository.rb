require_relative './invoice'
require 'time'
require 'pry'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = []
    invoices.each {|invoice| @invoices << Invoice.new(to_invoice(invoice))}
  end


  def to_invoice(invoice)
    invoice_hash = {}
    invoice.each do |line|
      invoice_hash[line[0]] = line[1]
    end
    invoice_hash
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @invoices
  end


  def find_by_id(input)
    @invoices.find do |invoice|
      invoice.id == input
    end
  end

  def find_all_by_customer_id(input)
    @invoices.find_all do |invoice|
      invoice.customer_id == input
    end
  end

  def find_all_by_merchant_id(input)
    @invoices.find_all do |invoice|
      invoice.merchant_id == input
    end
  end

  def find_all_by_status(input)
    @invoices.find_all do |invoice|
      invoice.status == input
    end
  end

  def find_highest_id
    @invoices.max_by(&:id).id
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at].nil?
      attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    invoice = Invoice.new(attributes)
    @invoices << invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if invoice.nil?
    else
      temp_attr = sterilize_attributes(attributes, invoice)
      pairs = attributes.keys.zip(temp_attr.values)
      pairs.each do |pair|
        invoice.attributes[pair[0]] = pair[1]
      end
      invoice.attributes[:updated_at] = Time.now
    end
  end

  def sterilize_attributes(attributes, invoice)
    temp_attr = attributes.dup
    temp_attr[:id] = invoice.attributes[:id]
    unless temp_attr[:status].nil?
      temp_attr[:status] = temp_attr[:status].to_sym
    end 
    temp_attr[:customer_id] = invoice.attributes[:customer_id]
    temp_attr[:merchant_id] = invoice.attributes[:merchant_id]
    temp_attr[:created_at] = invoice.attributes[:created_at]
    temp_attr
  end
end
