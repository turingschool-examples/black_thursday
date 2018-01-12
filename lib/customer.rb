require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(row, parent)
    @id             = row[:id].to_i
    @first_name     = row[:first_name]
    @last_name      = row[:last_name]
    @created_at     = Time.parse(row[:created_at])
    @updated_at     = Time.parse(row[:updated_at])
    @customer_repo  = parent
  end

  def invoices
    customer_repo.find_all_invoices_by_id(id)
  end

end
