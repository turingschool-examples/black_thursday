class Customer
  attr_reader :customer, :customer_repo
  def initialize(customer, customer_repo)
    @customer = customer
    @customer_repo = customer_repo
  end

  def id
    customer.fetch(:id).to_i
  end

  def first_name
    customer.fetch(:first_name)
  end

  def last_name
    customer.fetch(:last_name)
  end

  def created_at
    Time.parse(customer.fetch(:created_at))
  end

  def updated_at
    Time.parse(customer.fetch(:updated_at))
  end

  def merchants
    customer_repo.merchant_customers(self.id)
  end

end
