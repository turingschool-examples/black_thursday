require 'csv'
require_relative 'invoice.rb'

class InvoiceRepository
  def initialize(filepath, parent)
    @invoices = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @invoices
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row, self)
    end
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

  def find_all_by_status(id)
    @invoices.find_all do |invoice|
      invoice.status == id
    end
  end

  def invoice_repo_finds_merchant_via_engine(id)
    @parent.engine_finds_merchant_via_merchant_repo(id)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
