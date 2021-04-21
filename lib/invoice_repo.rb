require 'CSV'
require 'time'
require 'invoice'
require_relative 'findable'

class InvoiceRepo
  include Findable
  attr_reader :invoices,
              :engine

  def initialize(path, engine)
    @invoices = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def add_invoice(invoice)
    @invoices << invoice
  end

  def create(attributes)
    invoice = Invoice.new(attributes, self)
    max = @invoices.max_by do |invoice|
      invoice.id
    end
    invoice.update_id(max.id)
    add_invoice(invoice)
    invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id, @invoices)
    return if !invoice
    invoice.update_all(attributes)
  end

  def delete(id)
    @invoices.delete(find_by_id(id, @invoices))
  end

  def invoice_count
    count = all.length
    count.to_f
  end

  def average_invoices_per_merchant
    (invoice_count / @engine.merchant_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average_invoice = average_invoices_per_merchant
    sum = invoice_count_per_merchant.sum do |invoice, count|
      (average_invoice - count)**2
    end
    sum = (sum / (@engine.merchant_count - 1))
    (sum ** 0.5).round(2)
  end

  def invoice_count_per_merchant
    merchant_invoices = {}
    @invoices.each do |invoice|
      merchant_invoices[invoice.merchant_id] = find_all_by_merchant_id(invoice.merchant_id, @invoices).length
    end
      merchant_invoices
  end

  def find_all_by_day_created(day)
    @invoices.find_all do |invoice|
      invoice.created_at.strftime("%A") == day
    end
  end

  def invoice_count_per_day
    day_count = {}
    @invoices.each do |invoice|
      day_count[invoice.created_at.strftime("%A")] = find_all_by_day_created(invoice.created_at.strftime("%A")).length
    end
      day_count
  end

  def find_all_by_date(date) #spec
    @invoices.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def find_all_pending
    @invoices.find_all do |invoice|
      invoice.status != "success"
    end
  end

  def invoices_by_merchant
    @invoices.group_by do |invoice|
      invoice.merchant_id
    end.compact
  end

  def top_merchants_by_invoice_count
    two_deviation = (@engine.average_items_per_merchant_standard_deviation * 2) + @engine.average_invoices_per_merchant
    high_merchants = []
    invoice_count_per_merchant.find_all do |id, count|
      high_merchants << @engine.merchants.all.find_by_id(id, @engine.merchants.all) if count > two_deviation
    end
    high_merchants
  end

  def bottom_merchants_by_invoice_count
    two_deviation = @engine.average_invoices_per_merchant - (@engine.average_items_per_merchant_standard_deviation * 2)
    low_merchants = []
    invoice_count_per_merchant.find_all do |id, count|
      low_merchants << @engine.merchants.all.find_by_id(id, @engine.merchants.all) if count < two_deviation
    end
    low_merchants
  end

  def average_invoice_per_day_standard_deviation
    average_per_day = invoice_count / 7
    sum = invoice_count_per_day.sum do |invoice, count|
      (average_per_day - count)**2
    end
    sum = (sum / (7 - 1))
    (sum ** 0.5).round(2)
  end

  def top_days_by_invoice_count
    one_deviation = (invoice_count / 7) + average_invoice_per_day_standard_deviation
    top_days = []
    invoice_count_per_day.find_all do |day, count|
      top_days << day if count > one_deviation
    end
    top_days
  end

  def invoice_status(status)
    ((find_all_by_status(status, @invoices).length / invoice_count) * 100).round(2)
  end

  def invoice_total(id)
    return 0 if !(@engine.invoice_paid_in_full?(id))
    total = find_all_by_invoice_id(id, @invoices).sum do |invoice|
      (invoice.unit_price * invoice.quantity) if @engine.invoice_paid_in_full?(id)
    end
    total.round(2)
  end

  def total_revenue_by_date(date)
    @engine.find_all_by_date(date).sum do |invoice|
      invoice_total(invoice.id).round(2)
    end
  end

  def revenue_by_merchant_id
     merchants = Hash.new(0)
     invoices_by_merchant.each do |merchant, invoice|
       merchants[merchant] = invoice.sum do |invoice|
         invoice_total(invoice.id)
       end
     end
     merchants
  end
end
