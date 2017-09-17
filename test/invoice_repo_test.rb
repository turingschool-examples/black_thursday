require_relative 'test_helper'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv"})
    SalesEngine.from_csv(files).invoices
  end


end
