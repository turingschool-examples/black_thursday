class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :cr

  def initialize(id, first_name, last_name,
                created_at, updated_at, cr)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @cr = cr
  end

  def merchants
    cr.fetch_merchants_from_customer_id(id)
  end
end
