require 'pry'
class Merchant

  attr_reader :id,
              :name

  def initialize(data, repo=nil)
    @id     = data[:id].to_i
    @name   = data[:name]
    @parent = repo
  end

  def items
    @parent.items_of_merchant(id)
  end

  def invoices
    @parent.invoice_item(merchant_id)
  end
end
