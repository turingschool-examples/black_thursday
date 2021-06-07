require_relative '../lib/modules/timeable'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  include Timeable

  def initialize(data)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = update_time(data[:created_at].to_s)
    @updated_at = update_time(data[:updated_at].to_s)
  end

  def update(attributes)
    @first_name = attributes[:first_name] unless attributes[:first_name].nil?
    @last_name = attributes[:last_name] unless attributes[:last_name].nil?
    @updated_at = update_time('')
  end
end
