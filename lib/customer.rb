require 'time'

class Customer

  attr_reader     :id,
                  :first_name,
                  :last_name,
                  :created_at,
                  :updated_at,
                  :customer_repo

  def initialize(attributes, parent = nil)
    @id             = attributes[:id].to_i
    @first_name     = attributes[:first_name]
    @last_name      = attributes[:last_name]
    @created_at     = Time.parse(attributes[:created_at])
    @updated_at     = Time.parse(attributes[:updated_at])
    @customer_repo  = parent
  end

  def merchants
    invoices = @customer_repo.find_invoices_by_customer_id(@id)
    invoices.map do |invoice|
      invoice.merchant
    end.uniq
  end

end
