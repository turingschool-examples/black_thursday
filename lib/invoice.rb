require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :status, :updated_at
  def initialize(stats)
    @id = stats[:id].to_i
    @customer_id = stats[:customer_id].to_i
    @merchant_id = stats[:merchant_id].to_i
    @status = stats[:status].to_sym
    @created_at = Time.parse(stats[:created_at])
    @updated_at = Time.parse(stats[:updated_at])
  end

end
