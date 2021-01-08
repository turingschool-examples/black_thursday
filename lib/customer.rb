require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize (data, repository)
    @id          = data[:id]
    @first_name  = data[:first_name]
    @last_name   = data[:last_name]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @repository  = repository
  end

  def update_attributes (new_attributes)
    @first_name = new_attributes[:first_name]
    @last_name = new_attributes[:last_name]
  end
end
