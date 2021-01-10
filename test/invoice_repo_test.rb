require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/sales_engine'


class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({items: "./data/items.csv"})
    @invoice_repo = InvoiceRepository.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_attributes
    assert_equal 4985, @invoice_repo.invoices.count
  end
end
