require_relative 'invoice'
require_relative 'csv_parser'

class InvoiceRepository

  include CSV_parser

  attr_reader :all,
              :parent

  def initialize(file, parent = nil)
    @all = parse(file).map do |row|
      Invoice.new({ :id => row[:id],
                    :customer_id => row[:customer_id],
                    :merchant_id => row[:merchant_id],
                    :status => row[:status],
                    :created_at => row[:created_at],
                    :updated_at => row[:updated_at]},
                    self
                  )
    end
    @parent = parent
  end

  def find_by_id(id)
    all.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.find_all {|invoice| invoice.status == status}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_merchant(merchant_id)
    parent.find_by_merchant_id(merchant_id)
  end

end