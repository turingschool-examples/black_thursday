require_relative './time_formatter'

class Customer
  include TimeFormatter
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer_data, parent = nil)
    @id         = customer_data[:id].to_i
    @first_name = customer_data[:first_name].to_s
    @last_name  = customer_data[:last_name].to_s
    @created_at = format_time(customer_data[:created_at].to_s)
    @updated_at = format_time(customer_data[:updated_at].to_s)
    @parent     = parent
  end

  def merchants
    invoices = @parent.find_invoices_by_customer_id(id)
    invoices.map do |invoice|
      @parent.find_merchant_by_merchant_id(invoice.merchant_id)
    end
  end
end
