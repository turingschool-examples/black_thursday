require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @customer_repository = parent
  end

  def invoices
    @customer_repository.find_invoices_by_customer_id(@id)
  end

  def merchants
    invoices.map do |invoice|
      invoice.merchant
    end
  end
end
