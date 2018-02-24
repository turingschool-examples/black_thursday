require 'time'
require 'bigdecimal'
require 'pry'
require_relative '../lib/invoice'

# class for invoices
class InvoiceRepository
  def initialize(filepath, parent)
    @invoices = []
    @parent = parent
    load_invoices(filepath)
  end

  def all
    @invoices
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
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

  def pass_merchant_id_to_se_for_invoice(id)
    @parent.pass_merchant_id_to_merchant_repo(id)
  end

  def pass_id_to_se_for_item(id)
    @parent.pass_id_to_invoice_items_repo(id)
  end

  def pass_id_to_se_for_transaction(id)
    @parent.pass_id_to_transaction_repo(id)
  end

  def pass_id_to_se_for_customer(id)
    @parent.pass_id_to_customer_repo(id)
  end

  def pass_id_to_se_for_customer(id)
    @parent.pass_id_to_customer_repo(id)
  end

  def pass_item_id_to_se(id)
    @parent.items.find_by_id(id)
  end
end
