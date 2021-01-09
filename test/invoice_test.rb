
require_relative ‘test_helper’
require ‘./invoice’

class InvoiceTest < MiniTest::Test
  def setup
    merchant_path = “./data/merchants.csv”
    arguments = merchant_path
    #parent = mock(“parent”)
    @engine = SalesEngine.from_csv(arguments)
    @invoice = @engine.invoices.find_by_id(3452)
  end
