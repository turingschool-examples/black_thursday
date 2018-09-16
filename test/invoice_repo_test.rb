require_relative  "test_helper"
require_relative '../lib/invoice_repository.rb'

class InvoiceRepositoryTest <  Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new('./data/items_tiny.csv', self)
    assert_instance_of InvoiceRepository, ir
  end

end
