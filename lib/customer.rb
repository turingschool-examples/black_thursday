require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data_files, customer_repo)
    @id = data_files[:id].to_i
    @first_name = data_files[:first_name]
    @last_name = data_files[:last_name]
    @created_at = Time.parse(data_files[:created_at].to_s)
    @updated_at = Time.parse(data_files[:updated_at].to_s)
  end
end
