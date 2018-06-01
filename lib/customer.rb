require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

  def update_first_name(new_name)
    @first_name = new_name
  end

  def update_last_name(new_name)
    @last_name = new_name
  end

  def new_update_time(new_time)
    @updated_at = new_time
  end
end
