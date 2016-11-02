require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all, :parent

  def initialize(file_path, parent)
    @all = parse_invoices(file_path)
    @parent = parent
  end

  def parse_invoices(file_path)
    invoice_data = []
    CSV.foreach(file_path, headers:true) do |row|
      invoice_data << Invoice.new({ :id => row['id'],
                                    :customer_id => row['customer_id'],
                                    :merchant_id => row['merchant_id'],
                                    :status => row['status'],
                                    :created_at => row['created_at'],
                                    :updated_at => row['updated_at']},
                                  self)
    end
    invoice_data
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

end