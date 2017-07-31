require_relative 'invoice'
require 'csv'

class InvoiceRepository

  attr_reader :file_path,
              :sales_engine,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo      = {}
    load_repo
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice_identification = row[:id]
      invoice = Invoice.new(row, self)
      @id_repo[invoice_identification.to_i] = invoice
    end
  end

  def all
    id_repo.map do |id, invoice_info|
      invoice_info
    end
  end

  def find_by_id(id)
    id_repo[id]
  end

  def find_all_by_customer_id(customer_id)
    id_repo.values.select do |invoice_instance|
      invoice_instance.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    id_repo.values.select do |invoice_instance|
      invoice_instance.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    id_repo.values.select do |invoice_instance|
      invoice_instance.status == status
    end
  end

  def invoice_repo_to_se_merchant(merchant_id)
    @sales_engine.merchant_by_merchant_id(merchant_id)
  end

  def invoice_repo_to_se_items(invoice_id)
    @sales_engine.items_by_invoice_id(invoice_id)
  end

  def invoice_repo_to_se_transactions(invoice_id)
    @sales_engine.transactions_by_invoice_id(invoice_id)
  end

  def invoice_repo_to_se_customer(customer_id)
    @sales_engine.customer_by_customer_id(customer_id)
  end

  def invoice_repo_to_se_invoice_items(invoice_id)
    @sales_engine.invoice_items_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
