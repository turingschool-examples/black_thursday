require_relative 'repository/record'


class Invoice < Repository::Record

  attr_reader :customer_id, :merchant_id, :status
  def initialize(repo, fields)
    super(repo, fields)
    @customer_id =  fields[:customer_id].to_i
    @merchant_id =  fields[:merchant_id].to_i
    @status =       fields[:status].to_sym
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

  def customer
    repo.parent(:customers, customer_id)
  end

  def invoice_items
    repo.children(:invoice_items, id)
  end

  def transactions
    repo.children(:transactions, id)
  end

  def items
    invoice_items.map{ |invoice_item| invoice_item.item }
  end

end
