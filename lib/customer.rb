class Customer
attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :cr

  def initialize(data_hash, customer_repo)
    @id         = data_hash[:id].to_i
    @first_name = data_hash[:first_name]
    @last_name  = data_hash[:last_name]
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
    @cr = customer_repo
  end

  def merchants
    cr.se.invoices.find_all_by_customer_id(id).map { |invoice| invoice.merchant }
  end
end