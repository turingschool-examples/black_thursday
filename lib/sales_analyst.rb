require_relative 'sales_engine'
require_relative 'time_calculation'
require_relative 'math_calculation'
require_relative 'merchant_analysis'
require_relative 'invoice_analysis'
require_relative 'customers_analysis'
require 'bigdecimal'

class SalesAnalyst
  include MerchantAnalysis
  include CustomersAnalysis
  include InvoiceAnalysis
  include TimeCalculation
  include MathCalculation

  attr_reader :se

  def initialize(se)
    @se = se
  end

end
