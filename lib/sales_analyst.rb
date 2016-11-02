require_relative 'sales_engine'
require_relative 'item_analyst'
require_relative 'merchant_analyst'
require_relative 'calculator'

class SalesAnalyst

  include ItemAnalyst
  include MerchantAnalyst
  include Calculator

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end