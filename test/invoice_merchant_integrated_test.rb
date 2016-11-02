require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class InvoiceMerchantIntegratedTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :invoices => "./data_fixtures/invoices_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
  end
  
end