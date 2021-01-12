require 'CSV'
require_relative './cleaner.rb'
require_relative './invoice.rb'


class InvoiceRepository
  attr_accessor :invoices

  def initialize(file = './data/invoices.csv', engine)
    @engine = engine
    @file = file
    @invoices = {}
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    build_invoices
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def build_invoices
    @data.each do |invoice|
      cleaner = Cleaner.new
      @invoices[invoice[:id].to_i] = Invoice.new({
                                        :id => cleaner.clean_id(invoice[:id]),
                                        :customer_id  => cleaner.clean_id(invoice[:customer_id]),
                                        :merchant_id  => cleaner.clean_id(invoice[:merchant_id]),
                                        :status => cleaner.clean_status(invoice[:status]),
                                        created_at: cleaner.clean_date(invoice[:created_at]),
                                        updated_at: cleaner.clean_date(invoice[:updated_at])}, self)
      end
  end

  def all
    @invoices.values
  end

  def find_by_id(id)
    @invoices[id]
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |invoice|
      invoice.merchant_id == merch_id
    end
  end

  def find_all_by_status(status)
    stats = []
    all.find_all do |row|
      row.status == status
    end
  end

  def status_by_merchant_id(status)
    find_all_by_status(:pending).map do |invoice|
      invoice.merchant_id
    end
  end

  def create(attributes)
    new = Invoice.new(attributes, self)
    new_id = (max_id + 1)
    @invoices[new_id] = new
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if invoice != nil
      attributes.each do |key, value|
        invoice.update({key => value})
      end
    end
    invoice
  end

  def max_id
    @invoices.keys.max
  end

  def delete(id)
    @invoices.delete(id)
  end

  def invoices_per_weekday
    invoices_per_weekday = {}
    all.each do |invoice|
      invoices_per_weekday[invoice.created_day] ||= []
      invoices_per_weekday[invoice.created_day] << invoice
    end
    invoices_per_weekday
  end
end
