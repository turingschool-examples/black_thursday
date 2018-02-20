require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

	def test_it_exists
		invoice = InvoiceRepository.new

		assert_instance_of invoice, InvoiceRepository
	end

end