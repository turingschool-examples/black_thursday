require 'csv'
require 'bigdecimal'
require 'time'

class Customer

  attr_reader   :id,
                :whole_name,
                :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(data)
    @id           = data[:id]
    @first_name   = data[:first_name]
    @last_name    = data[:last_name]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @whole_name   = whole_name
  end

  def whole_name
    @first_name + " " + @last_name
  end
  
end
