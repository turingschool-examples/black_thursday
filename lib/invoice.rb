require_relative "../lib/data_access"

class Invoice
  include DataAccess
  #do attr_readers from  interfere with each other?
  #it seems wherever you put readers, it initializes, either here, or in module. 
  # attr_reader :customer_id, :status

  # def initialize
  #   @customer_id = data[:customer_id]
  # end



###
#duplicated from Item. Should we move to data_access?
###
  def merchant
    parent.parent.merchants.find_by_id(merchant_id)
  end

  def items
    binding.pry
    #The problem seems to be occurring in merchant
    merchant.items
  end

  def transactions
    parent.parent.transactions.find_all_by_invoice_id(id)
  end

  def customer
    parent.parent.customers.find_by_id(customer_id)
  end


end