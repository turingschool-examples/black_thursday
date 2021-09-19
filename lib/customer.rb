require 'Time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info)
    @id           = info[:id].to_i
    @first_name   = info[:first_name]
    @last_name    = info[:last_name]
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
  end

  def change_first_name(new_name)
    @first_name = new_name
    @updated_at = Time.now.utc
  end

  def change_last_name(new_name)
    @last_name = new_name
    @updated_at = Time.now.utc
  end
end
