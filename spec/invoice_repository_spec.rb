require 'rspec'
require './lib/invoice_repository'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

RSpec.describe InvoiceRepository do
  it 'exists' do
    mock_engine = double("sales_engine mock") #create invoice_fixtures
    invoice_repo = InvoiceRepository.new('./spec/fixtures/invoice_fixtures.csv', mock_engine)

    expect(invoice_repo).to be_an_instance_of(InvoiceRepository)
  end
end
