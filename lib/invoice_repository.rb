require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :repository
  def initialize(data, sales_engine = nil)
    @sales_engine = sales_engine
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Invoice.new(data, self)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    repository[id]
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |invoice|
      invoice.merchant_id == merch_id
    end
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_all_by_created_at(date)
    all.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def fetch_merchant_id(merchant_id)
    @sales_engine.fetch_merchant_id(merchant_id)
  end

  def fetch_invoice_id_for_items(id)
    @sales_engine.fetch_invoice_id_for_items(id)
  end

  def fetch_invoice_id_for_transactions(id)
    @sales_engine.fetch_invoice_id_for_transactions(id)
  end

  def fetch_invoice_id_for_customers(id)
    @sales_engine.fetch_invoice_id_for_customers(id)
  end

  def fetch_invoice_id_for_invoice_items(id)
    @sales_engine.fetch_invoice_id_for_invoice_items(id)
  end

  def fetch_invoice_items(id)
    @sales_engine.fetch_invoice_items(id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
