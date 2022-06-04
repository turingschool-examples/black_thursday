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

  it "can return an array of all invoices" do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    expect(invoice_repo.all.count).to eq(4985)
  end

  it "can find a invoice by an id" do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    expect(invoice_repo.find_by_id(1)).to be_a(Invoice)
    expect(invoice_repo.find_by_id(123542345293423)).to eq(nil)
  end

  it "can find all invoices by a specific customer id" do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    item_repo = ItemRepository.new('./data/items.csv')
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    expect(invoice_repo.find_all_by_customer_id(1)).to be_instance_of(Array)
    expect(invoice_repo.find_all_by_customer_id(1).length).to eq(3)
    expect(invoice_repo.find_all_by_customer_id(12345678910112)).to eq([])
  end
end
