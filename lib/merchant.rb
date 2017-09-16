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
    sales_engine = @parent.parent
    sales_engine.invoices.find_all_by_merchant_id(id)
  end
end
