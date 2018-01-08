require_relative '../lib/invoice'
require 'csv'

class InvoiceRepository
  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Invoice.new({:id           => row[:id].to_i,
                   :customer_id  => row[:customer_id].to_i,
                   :merchant_id  => row[:merchant_id].to_i,
                   :status       => row[:status],
                   :created_at   => row[:created_at],
                   :updated_at   => row[:updated_at]
                   }, self)
    end
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def call_merchant_from_merchant_id(merchant_id)
    parent.get_merchant_from_merchant_id(merchant_id)
  end

  def call_items_from_invoice_id(invoice_id)
    parent.get_items_from_invoice_id(invoice_id)
  end

  def call_transactions_from_invoice_id(invoice_id)
    parent.get_transactions_from_invoice_id(invoice_id)
  end

  def call_customer_from_customer_id(customer_id)
    parent.get_customer_from_customer_id(customer_id)
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    all.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    all.select do |invoice|
      invoice.status == status.to_sym
    end
  end

  def invoice_paid_in_full?(invoice_id)
    parent.is_invoice_paid_in_full?(invoice_id)
  end

  def invoice_total(invoice_id)
    parent.get_invoice_total(invoice_id)
  end

end
