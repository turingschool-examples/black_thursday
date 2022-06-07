require 'bigdecimal'
require 'time'

class Customer

attr_reader :id
attr_accessor :created_at, :updated_at, :first_name, :last_name

  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

end
