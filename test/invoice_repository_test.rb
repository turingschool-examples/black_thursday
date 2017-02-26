require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @path = "./data/invoices_fixture.csv"
  end

  def test_it_exist
    invoice_repository = InvoiceRepository.new(@path, self)
    assert_instance_of InvoiceRepository, invoice_repository
    # binding.pry
  end

  # def test_se_makes_invoice_repo
  #   se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    
  #   invoice_repo = se.invoices
  #   invoice = se.invoices.find_by_id(6)

  #   assert_instance_of InvoiceRepository, invoice_repo
  # end 

  # def test_makes_invoice
  #   se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  #   invoice = se.invoices.find_by_id(6)

  #   assert_instance_of Invoice, invoice
  # end 
end