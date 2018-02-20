require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_name   = "./data/invoices.csv"
    @invoice_repo = InvoiceRepository.new(file_name)
  end

	def test_it_exists
	assert_instance_of InvoiceRepository, @invoice_repo 
	end

	# def	test_it_finds_invoice_id
  #   assert_nil @invoice_repo.find_by_id(6)
  #   assert_instance_of Merchant, @merch_repo.find_by_id('12334105')
  #   assert_equal 'Shopin1901', @merch_repo.find_by_id('12334105').name
  # end

end