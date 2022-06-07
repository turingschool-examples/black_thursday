require 'csv'
require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(data_hash)
    @id = data_hash[:id].to_i
    @customer_id = data_hash[:customer_id].to_i
    @merchant_id = data_hash[:merchant_id].to_i
    @status = data_hash[:status].to_sym
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
  end
end
