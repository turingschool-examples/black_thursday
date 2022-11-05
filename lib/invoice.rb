require 'time'

class Invoice
  attr_reader :customer_id,
              :merchant_id,
              :repo
                            
  attr_accessor :id,
                :created_at,
                :updated_at,
                :status

  def initialize(attributes, repo = nil)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status].to_sym
    @created_at   = time_converter(attributes[:created_at])
    @updated_at   = time_converter(attributes[:updated_at])
    @repo = repo
  end

  def time_converter(attributes)
    return unless attributes
    Time.parse(attributes)
  end
end
