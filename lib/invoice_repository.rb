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
    all.find {|invoice| invoice.id.eql?(desired_id)}
  end

  def find_all_by_merchant_id(desired_id)
    all.find_all {|invoice| invoice.merchant_id.eql?(desired_id)}
  end

  def find_all_by_customer_id(desired_id)
    all.find_all {|invoice| invoice.customer_id.eql?(desired_id)}
  end

  def find_all_by_status(desired_status)
    all.find_all {|invoice| invoice.status.eql?(desired_status)}
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
  end

end