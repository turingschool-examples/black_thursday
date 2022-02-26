require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require 'CSV'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe InvoiceRepository do

  before(:each) do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    invoice = se.invoices.find_by_id(6)
  end

  it 'exists' do
    expect(se).to be_a(InvoiceRepository)
    expect(invoice).to be_a(Invoice)

  end

end
