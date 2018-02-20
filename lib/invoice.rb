require_relative 'searching'

class Invoice
  attr_reader :id,
              :customer_id
  
  def initialize(data)
    @id = data[:id]
    @customer_id = data[:customer_id]
  end

end