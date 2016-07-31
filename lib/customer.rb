class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer_details, repo = nil)
    @id         = customer_details[:id].to_i
    @first_name = customer_details[:first_name]
    @last_name  = customer_details[:last_name]
    @created_at = format_time(customer_details[:created_at].to_s)
    @updated_at = format_time(customer_details[:updated_at].to_s)
    @parent     = repo
  end

  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end

  def merchants
    invoices = @parent.find_invoices_by_customer_id(id)
    invoices.map do |invoice|
      @parent.find_merchant_by_merchant_id(invoice.merchant_id)
    end
  end
end
