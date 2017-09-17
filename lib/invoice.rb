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
      @date = Time.new(invoice_data[:created_at]).strftime('%A')
  end

  def merchant
      @invoice_repository.sales_engine.merchants.find_by_id(@merchant_id)
  end

  def day_of_the_week
    case date
    when 'Sunday'
      'Saturday'
    when 'Monday'
      'Sunday'
    when 'Tuesday'
      'Monday'
    when 'Wednesday'
      'Tuesday'
    when 'Thursday'
      'Wednesday'
    when 'Friday'
      'Thursday'
    when 'Saturday'
      'Friday'
    end
  end

  def items
    @invoice_repository.find_all_items_by_invoice_id(@id)
  end



end
