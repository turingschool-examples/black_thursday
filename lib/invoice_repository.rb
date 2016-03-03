

class InvoiceRepository

  attr_accessor :repository
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    @repository
  end

  def find_by_id(invoice_id)
    repository.find do |invoice|
      invoice.id == invoice_id
    end
  end

  def find_all_by_customer_id(customer_id)
    repository.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    repository.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    repository.find_all do |invoice|
      invoice.status == status
    end
  end

  def inspect
  end

end
