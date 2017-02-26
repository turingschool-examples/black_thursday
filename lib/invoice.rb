require_relative "../lib/data_access"

class Invoice
  include DataAccess
  #do attr_readers from  interfere with each other?
  #it seems wherever you put readers, it initializes, either here, or in module. 
  # attr_reader :customer_id, :status

  # def initialize
  #   @customer_id = data[:customer_id]
  # end

end