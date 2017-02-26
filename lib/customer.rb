class Customer
  attr_reader :customer_hash, :repository

  def initialize(hash, repository = '')
    @customer_hash = hash
    @repository = repository
  end

  def id
    customer_hash[:id]
  end

  def first_name
    customer_hash[:first_name]
  end

  def last_name
    customer_hash[:last_name]
  end

  def created_at
    customer_hash[:created_at]
  end

  def updated_at
    customer_hash[:updated_at]
  end
end
