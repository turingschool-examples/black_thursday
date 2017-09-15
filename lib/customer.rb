require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info, parent=nil)
    @id          = info[:id].to_i
    @first_name  = info[:first_name].to_s
    @last_name   = info[:last_name].to_s
    @created_at  = Time.parse(info[:created_at].to_s)
    @updated_at  = Time.parse(info[:updated_at].to_s)
  end
end

  