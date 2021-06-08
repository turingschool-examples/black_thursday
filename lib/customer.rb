require 'CSV'
require 'time'
class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer_data, repo)
    @id = customer_data[:id].to_i
    @first_name = customer_data[:first_name].to_s
    @last_name = customer_data[:last_name].to_s
    @created_at = Time.parse(customer_data[:created_at].to_s)
    @updated_at = Time.parse(customer_data[:updated_at].to_s)
    @repo = repo
  end

  def update_time
    @updated_at = Time.now
  end

  def change_first_name(first_name)
    @first_name = first_name
  end

  def change_last_name(last_name)
    @last_name = last_name
  end
end
