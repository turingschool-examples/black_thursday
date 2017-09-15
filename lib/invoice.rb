require 'time'
require 'date'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :date

  def initialize(invoice_data, invoice_repository)
      @id = invoice_data[:id].to_i
      @customer_id = invoice_data[:customer_id].to_i
      @merchant_id = invoice_data[:merchant_id].to_i
      @status = invoice_data[:status].to_sym
      @created_at = Time.parse(invoice_data[:created_at])
      @updated_at = Time.parse(invoice_data[:updated_at])
      @invoice_repository = invoice_repository
      @date = Date.new(invoice_data[:created_at].to_i)
  end

  def merchant
      @invoice_repository.sales_engine.merchants.find_by_id(@merchant_id)
  end

  def day_of_the_week
    day_number = date.cwday
    case day_number
    when 1
      'Monday'
    when 2
      'Tuesday'
    when 3
      'Wednesday'
    when 4
      'Thursday'
    when 5
      'Friday'
    when 6
      'Saturday'
    when 7
      'Sunday'
    end

  end
end
