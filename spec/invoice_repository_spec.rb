require './lib/item.rb'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/invoice'
require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it "exists" do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    expect(invoice_repo).to be_a(InvoiceRepository)
  end
end
