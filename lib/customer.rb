require 'time'
require 'bigdecimal'

class Customer
  attr_reader   :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(customer_data, parent = nil)
    @customer_parent = parent
    @id             = customer_data[:id].to_i
    @first_name     = customer_data[:first_name]
    @last_name      = customer_data[:last_name]
    @created_at     = determine_the_time(customer_data[:created_at])
    @updated_at     = determine_the_time(customer_data[:updated_at])
  end

  def merchant
    @customer_parent.parent.merchants.find_by_id(@merchant_id)
  end

  def find_unit_price(price)
    if unit_price == ""
      unit_price = BigDecimal.new(0)
    else
      unit_price = BigDecimal.new(price) / 100
    end
    unit_price
  end

  def unit_price_to_dollars(unit_price)
    @unit_price.to_f
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end