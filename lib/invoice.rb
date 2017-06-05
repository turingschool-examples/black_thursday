require_relative '../lib/invoice_repository'

class Invoice
    attr_reader :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at
  end

  def initialize

  end
  
  def all

  end

  def find_by_id

  end

  def find_all_by_customer_id

  end

  def find_all_by_merchant_id

  end

  def find_all_by_status

  end

end

se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
invoice = se.invoices.find_by_id(6)
