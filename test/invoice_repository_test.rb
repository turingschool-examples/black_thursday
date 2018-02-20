require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_name   = "./data/invoices.csv"
    @invoice_repo = InvoiceRepository.new(file_name)
  end

	def test_it_exists
		assert_instance_of InvoiceRepository, @invoice_repo 
	end

	def	test_it_finds_invoice_id
		assert_equal "hi", @invoice_repo.find_by_id(6)
    # assert_instance_of Invoice, @invoice_repo.find_by_id(6)
  end

end