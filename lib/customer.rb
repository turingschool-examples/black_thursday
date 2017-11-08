require 'time'

class Customer
  attr_reader :id,
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
    @customer_repo.find_invoices_by_customer_id(@id).map do |invoice|
      invoice.merchant
    end.uniq
  end

  def find_invoices_linked_to_customer
    @customer_repo.find_invoices_by_customer_id(id)
  end

  def fully_paid_invoices
    find_invoices_linked_to_customer.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def unpaid_invoices
    find_invoices_linked_to_customer.find_all do |invoice|
      invoice.not_paid_in_full?
    end
  end

end
