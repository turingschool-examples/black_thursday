require 'time'
require 'bigdecimal'

class Invoice

  attr_accessor :info

  def initialize(info)
    @info = info
  end

  def id
    id = @info[:id].to_i
  end

  def customer_id
    name = @info[:customer_id].to_i
  end

  def merchant_id
    merchant_id = @info[:merchant_id].to_i
  end

  def status
    status = @info[:status]
  end

  def created_at
    created_at = @info[:created_at].utc
  end

  def updated_at
    updated_at = @info[:updated_at].utc
  end

end
