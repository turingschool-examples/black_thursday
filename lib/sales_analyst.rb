require_relative 'sales_engine'
require_relative 'item_analyst'
require_relative 'merchant_analyst'

class SalesAnalyst

  include ItemAnalyst
  include MerchantAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end