require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
      @id = data[:id].to_i
      @customer_id = data[:customer_id].to_i
      @merchant_id = data[:merchant_id].to_i
      @status = data[:status].to_sym
      @created_at = Time.parse(data[:created_at])
      @updated_at = Time.parse(data[:updated_at])
      @parent = parent
  end

  def merchant
    parent.find_merchant(merchant_id)
  end

end