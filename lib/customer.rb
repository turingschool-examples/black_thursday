class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customers, customer_repo)
    @customer_repo = customer_repo
    @id         = customers[:id].to_i
    @first_name = customers[:first_name]
    @last_name  = customers[:last_name]
    @created_at = Time.parse(customers[:created_at].to_s)
    @updated_at = Time.parse(customers[:updated_at].to_s)
  end

  def merchants
    invoices = @customer_repo.se.invoices.find_all_by_customer_id(@id)
    merchants = invoices.map do |invoice|
      @customer_repo.se.merchants.find_by_id(invoice.merchant_id)
    end
  end

end
