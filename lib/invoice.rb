require_relative 'repository/record'
require 'time'

class Invoice < Repository::Record

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(repo, fields)
    super(repo, fields)
    @id =           fields[:id].to_i
    @customer_id =  fields[:customer_id]
    @merchant_id =  fields[:merchant_id]
    @status =   fields[:status]
    @created_at = Time.parse([:created_at])
    @updated_at = Time.parse([:updated_at])
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

end
