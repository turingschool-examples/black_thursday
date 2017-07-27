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
    result = nil
    @invoices.each do |invoice|
      if invoice.id == id
        result = invoice
      end
    end
    result
  end

  def find_all_by_customer_id(cust_id)
    results = []
    @invoices.each do |invoice|
      if invoice.customer_id == cust_id
        results << invoice
      end
    end
    results
  end

  def find_all_by_merchant_id(merch_id) #- returns either [] or one or more matches which have a matching merchant ID
    results = []
    @invoices.each do |invoice|
      if invoice.merchant_id == merch_id
        results << invoice
      end
    end
    results
  end

  def find_all_by_status(state) #- returns either [] or one or more matches which have a matching status
    results = []
    @invoices.each do |invoice|
      if invoice.status == state
        results << invoice
      end
    end
    results
  end

  def add_data(data)
    @invoices << Invoice.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
