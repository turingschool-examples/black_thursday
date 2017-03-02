require_relative "../lib/item_data_access"
class Merchant
  # include ItemDataAccess
  attr_reader :id,
              :name,
              :parent,
              :created_at

  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @parent = parent
    @created_at = data[:created_at]
  end

  def items
    parent.parent.items.find_all_by_merchant_id(id)
  end

  def customers
    #and if we started with a merchant we could find the customers who’ve purchased one or more items at their store:
    parent.parent.invoices.find_all_by_merchant_id(id).map {|invoice| invoice.customer}.uniq
  end


###Taken from DataAccess, find_all_by_merchant_id. Refactor to extract find_all?
#def invoices
  #find_all(method_name)
    #all.select{ |item| item.method_name == method_name(which is same as instance var name) }
#I don't think you can pass in method calls as arguments... Except as a proc?

  def invoices
    parent.parent.invoices.find_all_by_merchant_id(@id)
  end

end


# m = Merchant.new({:id => 5, :name => "Turing School"})
