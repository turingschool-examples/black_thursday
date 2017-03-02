class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(info, customer_repo = '')
    @id            = info[:id].to_i
    @first_name    = info[:first_name]
    @last_name     = info[:last_name]
    @created_at    = info[:created_at]
    @updated_at    = info[:updated_at]
    @customer_repo = customer_repo
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchants
    customer_invoices(id).map do |invoice|
      invoice.invoice_repository.engine.merchants.find_by_id(invoice.id)
    end
  end

  private
  def customer_invoices(id)
    customer_repo.engine.invoices.find_all_by_customer_id(id)
  end
end
