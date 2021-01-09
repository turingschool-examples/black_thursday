require_relative 'test_helper'
require './invoice'
require './invoice_repository'
class InvoiceRepositoryTest < MiniTest::Test
  def setup
    merchant_path = "./data/merchants.csv"
    arguments = merchant_path
    #parent = mock("parent")
    @engine = SalesEngine.from_csv(arguments)
  end
