require_relative '../lib/invoice'
class InvoiceRepository
  attr_reader :invoices

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoices = []
  end

  def all # - returns an array of all known Invoice instances
  end

  def find_by_id #- returns either nil or an instance of Invoice with a matching ID
  end

  def find_all_by_customer_id #- returns either [] or one or more matches which have a matching customer ID
  end

  def find_all_by_merchant_id #- returns either [] or one or more matches which have a matching merchant ID
  end

  def find_all_by_status #- returns either [] or one or more matches which have a matching status
  end

  def add_data(data)
    @invoices << Invoice.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
