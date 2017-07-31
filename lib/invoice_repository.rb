require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :invoices

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoices = []
  end

  def all # - returns an array of all known Invoice instances
    @invoices
  end

  def find_by_id(id) #- returns either nil or an instance of Invoice with a matching ID
    @invoices.find {|i| i.id == id}
  end

  def find_all_by_customer_id(cust_id)
    @invoices.find_all {|i| i.customer_id == cust_id}
  end

  def find_all_by_merchant_id(merch_id) #- returns either [] or one or more matches which have a matching merchant ID
    @invoices.find_all {|i| i.merchant_id == merch_id}
  end

  def find_all_by_status(status) #- returns either [] or one or more matches which have a matching status
    @invoices.find_all {|i| i.status == status}
  end

  def add_data(data)
    @invoices << Invoice.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
