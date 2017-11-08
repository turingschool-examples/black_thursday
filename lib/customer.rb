class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent)
    @parent = parent
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end

  def merchants
    parent.find_merchant_by_customer_id(id)
  end

  def invoices
    parent.find_all_invoices_by_customer_id(id)
  end

  def fully_paid_invoices
    invoices.reduce([]) do |result, invoice|
      result << invoice if invoice.is_paid_in_full?
      result
    end
  end
end
