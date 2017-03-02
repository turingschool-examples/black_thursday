require_relative 'helper'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchants
    parent.find_merchants(id)
  end
end