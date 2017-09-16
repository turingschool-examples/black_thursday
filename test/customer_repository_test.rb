require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices => "./test/fixtures/invoices_fixture.csv",
      :customers => "./test/fixtures/customers_fixture.csv"
      })
      cr = se.customers
  end

end
