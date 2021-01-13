require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'
class InvoiceRepository
  attr_reader :path,
              :invoices,
              :engine

  def initialize(path, engine)
    @path = path
    @invoices = []
    read_invoice
    @engine = engine
  end

  def read_invoice
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row, self)
    end
    @invoices
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_all_by_date(date)
    @invoices.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def create(attributes, invoice_repository = invoice_repository)
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.new.to_s
    attributes[:id] = highest_id.id + 1
    @invoices.insert(2, Invoice.new(attributes, self))
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?

    update.status = attributes[:status]
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @invoices.delete(delete)
  end

  def highest_id
    @invoices.max do |invoice|
      invoice.id
    end
  end

  def per_merchant_invoice_count
    @invoices.each_with_object({}) do |invoice, acc|
      merchant_invoice_count = find_all_by_merchant_id(invoice.merchant_id).length
      acc[invoice.merchant_id] = merchant_invoice_count
    end
  end

  def invoices_per_day
    @invoices.each_with_object(days_hash) do |invoice, acc|
      # require "pry";binding.pry
      acc[invoice.day_of_week] += 1
    end
  end

  def days_hash
    days = { 'Monday' => 0,
             'Tuesday' => 0,
             'Wednesday' => 0,
             'Thursday' => 0,
             'Friday' => 0,
             'Saturday' => 0,
             'Sunday' => 0 }
  end

  def invoices_per_status
    status = { pending: 0,
               shipped: 0,
               returned: 0 }
    @invoices.each_with_object(status) do |invoice, acc|
      acc[invoice.status] += 1
    end
  end

  def create_merchant_id_hash
    starting_hash = Hash.new { |h, k| h[k] = [] }
    @invoices.each do |invoice|
      starting_hash[invoice.merchant_id] << invoice.id
    end
    starting_hash
  end
end
