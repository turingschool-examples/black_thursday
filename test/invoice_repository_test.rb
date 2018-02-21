require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_name   = "./data/sample-data/invoices.csv"
		@invoice_repo = InvoiceRepository.new(file_name)
		# se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  end

	def test_it_exists
		assert_instance_of InvoiceRepository, @invoice_repo 
	end

	def	test_it_finds_invoice_id
		assert_instance_of Array, @invoice_repo.all
		assert_nil @invoice_repo.find_by_id(10)
		# require 'pry'; binding.pry
		assert_equal " ", @invoice_repo.find_by_id(4)
  end

end