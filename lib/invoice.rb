require 'time'

require_relative 'repository/record'


class Invoice < Repository::Record

  attr_reader :customer_id, :merchant_id, :status
  def initialize(repo, fields)
    super(repo, fields)
    @customer_id =  fields[:customer_id]
    @merchant_id =  fields[:merchant_id]
    @status =   fields[:status]
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

end
