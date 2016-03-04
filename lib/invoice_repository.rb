

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
      invoice.id.to_i == invoice_id
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
      invoice.status == status.to_sym
    end
  end

  def percent_by_status(status_symbol)
    ((find_all_by_status(status_symbol).count/all.count.to_f)*100).round(2)
  end

#56.95 shipped

  def inspect
  end

end
