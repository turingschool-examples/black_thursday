class InvoiceRepository
  attr_reader :invoices

  def initialize(csv_data)
    @invoices = csv_data
  end
  # sales engine will be passed through each repo

  def all
    invoices
  # returns an array of all known Invoice instances
  end

  def find_by_id
    invoices.detect { |invoice| invoice.id == id }
  # returns either nil or an instance of Invoice with a matching ID
  end

  def find_all_by_customer_id
    invoices.select { |invoice| invoice.customer_id == customer_id }
  # returns either [] or one or more matches which have a matching customer ID
  end

  def find_all_by_merchant_id
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  # find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
  end

  def find_all_by_status
    invoices.select { |invoice| invoice.status == status }
  # find_all_by_status - returns either [] or one or more matches which have a matching status
  end


end
