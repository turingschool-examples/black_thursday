require_relative 'sales_engine'
require_relative 'invoice'
require_relative 'mathable'
require_relative 'repo_brain'

class InvoiceRepository
  include Mathable
  attr_reader :invoices

  def initialize(path, engine)
    @invoices = []
    @engine = engine
    make_invoices(path)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def make_invoices(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@invoices)
    @invoices << Invoice.new(attributes, self)
  end

  def delete(id)
    invoices.delete(find_by_id(id))
  end

  def find_all_by_customer_id(customer_id)
    RepoBrain.find_all_by_id(customer_id, 'customer_id', @invoices)
  end

  def find_all_by_merchant_id(merchant_id)
    RepoBrain.find_all_by_id(merchant_id, 'merchant_id', @invoices)
  end

  def find_all_by_status(status)
    RepoBrain.find_all_by_symbol(status, 'status', @invoices)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @invoices)
  end

  def invoices_by_days
    hash = { 'Sunday' => 0,
             'Monday' => 0,
             'Tuesday' => 0,
             'Wednesday' => 0,
             'Thursday' => 0,
             'Friday' => 0,
             'Saturday' => 0 }
    @invoices.each do |invoice|
      hash[invoice.day_created] += 1
    end
    hash
  end

  def find_invoice_items(invoice_id)
    @engine.find_invoice_items(invoice_id)
  end

  def invoice_paid_in_full?(invoice_id)
    @engine.invoice_paid_in_full?(invoice_id)
  end

  def invoice_total_value(invoice_id)
    @engine.invoice_total_value(invoice_id)
  end

  def merchant_successful_invoice_array(merchant_id)
    @invoices.each_with_object([]) do |invoice, array|
      if invoice.merchant_id == merchant_id && invoice.paid_in_full?
        array << invoice.id
      end
    end
  end

  def percentage_by_status(status)
    invoices_found = find_all_by_status(status).count.to_f
    total_invoices = all.count
    (invoices_found / total_invoices * 100).round(2)
  end

  def top_sales_days
    hash = invoices_by_days
    hash.each_with_object([]) do |(day, number_of_invoices), array|
      if number_of_invoices > (average(hash) + standard_deviation(hash))
        array << day
      end
    end
  end

  def total_revenue_by_date(date)
    @invoices.each_with_object([]) do |invoice, array|
      if invoice.created_at.strftime('%y%m%d') == date.strftime('%y%m%d')
        array << invoice.total_value
      end
    end.sum
  end

  def update(id, attributes)
    if find_by_id(id) != nil && attributes[:status] != nil
      invoice_to_update = find_by_id(id)
      invoice_to_update.status = attributes[:status].to_sym
      invoice_to_update.update_time_stamp
    end
  end
end
