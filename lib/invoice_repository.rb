require_relative'invoice'


class InvoiceRepository
  attr_reader :invoices,
              :find_all_by_description,
              :find_all_by_price_in_range

  def initialize(parent= nil)
    @invoices = []
    @sales_engine = parent
  end

  def create_invoice(data)
     CSV.foreach data, headers: true, header_converters: :symbol do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find{|invoice| invoice.id == id.to_s}
  end

  def find_all_by_customer_id(id)
    @invoices.find{|invoice| invoice.customer_id == id.to_s}
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find{|invoice| invoice.merchant_id == merchant_id}
  #@invoices.find{|invoice| name if invoice.name == name}
  end
  def find_all_by_status(status)
    @invoices.find{|invoice| invoice.status == status}

  #@invoices.find{|invoice| name if invoice.name == name}
  end
  def inspect
      "#<#{self.class} #{@invoices.size} rows>"
  end

end

#
# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
