class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(information, parent = nil)
    @id = information[:id]
    @first_name = information[:first_name]
    @last_name = information[:last_name]
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
    @parent = parent
  end

  def invoices
    sales_engine = parent.parent
    sales_engine.invoices.find_all_by_customer_id(id)
  end

  def merchants
    invoices.map { |invoice| invoice.merchant }.uniq
  end

end
