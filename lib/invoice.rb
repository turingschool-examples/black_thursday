require_relative './time_store_module'
require 'bigdecimal'

class Invoice
  include TimeStoreable
  
  attr_reader :status,
              :updated_at

  attr_accessor :id,
                :customer_id,
                :merchant_id,
                :created_at
               
  def initialize(data, repository)
    @id           = data[:id]
    @customer_id  = data[:customer_id].to_i
    @merchant_id  = data[:merchant_id].to_i
    @status       = data[:status]
    @created_at   = time_store(data[:created_at])
    @updated_at   = time_store(data[:updated_at])
    @repository   = repository
  end
end