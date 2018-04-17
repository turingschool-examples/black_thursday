require 'time'
class Invoice
  attr_accessor :attributes

  def initialize(data)
    modify(data)
    @attributes = data
  end

  def modify(data)
    data[:id] = data[:id].to_i
    data[:customer_id] = data[:customer_id].to_i
    data[:merchant_id] = data[:merchant_id].to_i
    data[:status] = data[:status].to_sym
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data[:unit_price_to_dollars] = data[:unit_price].to_f
    data
  end

  def id
    @attributes[:id]
  end

  def customer_id
    @attributes[:customer_id]
  end

  def merchant_id
    @attributes[:merchant_id]
  end

  def status
    @attributes[:status]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end


end
