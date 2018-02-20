require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
		@invoice_eng = InvoiceEngine.from_csv({:invoices => "./data/invoices.csv"})
		invoice = se.invoices.find_by_id(6)
  end

	def test_it_exists
		assert_instance_of InvoiceRepository, @invoice_eng 
	end

end