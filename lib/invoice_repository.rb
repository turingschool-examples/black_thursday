require 'csv'
require_relative 'invoice'
require_relative 'parser'

class InvoiceRepository
  include Parser
  attr_reader :all, :parent

  def initialize(file_path, parent)
    @all = create_invoices(file_path)
    @parent = parent
  end

  def create_invoices(file_path)
    data_row = parse_invoices_csv(file_path)
    data_row.map { |row| Invoice.new(row, self)}
  end

  def find_by_id(desired_id)
    all.find {|i| i.id.eql?(desired_id)}
  end

  def find_all_by_merchant_id(desired_id)
    all.find_all {|i| i.merchant_id.eql?(desired_id)}
  end

  def find_all_by_customer_id(desired_id)
    all.find_all {|i| i.customer_id.eql?(desired_id)}
  end

  def find_all_by_status(desired_status)
    all.find_all {|i| i.status.eql?(desired_status)}
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def find_all_by_date(date)
    all.find_all do |i|
      i.created_at.year == date.year && i.created_at.yday == date.yday
    end
  end

  def inspect
    "#{self.class}, #{all.count}"
  end

  def find_customer_by_id(customer_id)
    parent.find_customer_by_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    parent.find_transactions_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    parent.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    parent.find_item_by_item_id(item_id)
  end

end