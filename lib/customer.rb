require 'time'
require 'bigdecimal'
require 'csv'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at



  def initialize(data, repo = nil)
    @id          = data[:id].to_i
    @first_name  = data[:first_name]
    @last_name   = data[:last_name]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @parent      = repo
  end
  def merchants
  end
end
