# require_relative "../test/test_helper"

module ItemDataAccess
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent,
              :customer_id,
              :status,
              :item_id,
              :invoice_id,
              :quantity
  #status and customer_id are invoice readers. Consider whether it's drier to initialize invoice here (with extra instance variables) or in invoice (with similar/repeated instance variables)

  #check if merchants.all has unneeded nil instance variables.
  #Would .compact help?

  #OR, could we make a RepoDataAccess, and ItemDataAccess?


#rename as populate_variables
  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
    #  binding.pry
    @customer_id = data[:customer_id]
    @status = data[:status]

  end

end
