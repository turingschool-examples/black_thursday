class InvoiceRepository
  attr_reader :invoices, :engine

  def initialize(csv_data, engine)
    @invoices = csv_data
    @engine   = engine
  end

  def all
    invoices
  end

  def find_by_id
    invoices.detect { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id
    invoices.select { |invoice| invoice.customer_id == customer_id } || []
  end

  def find_all_by_merchant_id
    invoices.select { |invoice| invoice.merchant_id == merchant_id } || []
  end

  def find_all_by_status
    invoices.select { |invoice| invoice.status == status } || []
  end


end
