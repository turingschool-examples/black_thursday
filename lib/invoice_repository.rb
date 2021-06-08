require 'csv'
require_relative 'invoice'
require 'time'

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

  def invoice_id_by_merchant_id
    merchant_id_to_invoice_id = Hash.new{|h,k| h[k] = Array.new}
    @all.each do |invoice|
      merchant_id_to_invoice_id[invoice.merchant_id] << invoice.id
    end
    merchant_id_to_invoice_id
  end

  def group_invoices_by_merchant
    @all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def invoices_per_merchant
    merchant_invoices_total = []
    group_invoices_by_merchant.each do |merchant, invoices|
      merchant_invoices_total << invoices.length
    end
    merchant_invoices_total
  end

  def number_of_merchants
    invoices_per_merchant.length
  end

  def total_invoices
    @all.length
  end

  def group_invoices_by_created_date
    @all.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def invoices_per_day
    day_invoice_total = []
    group_invoices_by_created_date.each do |day, invoices|
      day_invoice_total << invoices.length
    end
    day_invoice_total
  end

  def invoices_by_created_date
    mappings = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
    group_invoices_by_created_date.transform_keys! do |day|
      mappings[day]
    end
  end

  def invoice_status_total(status)
    @all.select do |invoice|
      invoice.status == status
    end.count
  end

  # :nocov:
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  # :nocov:

  def find_invoice_by_date(date)
    @all.find_all do |invoice|
      invoice.created_at.strftime('%Y%m%d') == date.strftime('%Y%m%d')
    end
  end
end
