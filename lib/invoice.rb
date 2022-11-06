require_relative 'invoice_repository'
require 'pry'
require 'csv'

class Invoice

  attr_reader :id, 
              :customer_id, 
              :merchant_id,  
              :created_at, 
              :updated_at,
              :status

  def initialize(info)
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = info[:status].to_sym
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end

  def update(attributes)
    # require 'pry'; binding.pry

    @status = attributes[:status] if attributes[:status]
    @updated_at = Time.now
    # require 'pry'; binding.pry
    self
  end
  
end