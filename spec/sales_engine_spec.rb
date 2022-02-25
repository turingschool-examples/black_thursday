require 'rspec'
require 'csv'
require './lib/sales_engine'
require './lib/items_repository'
require './lib/merchants_repository'
require './lib/invoice_items_repository'

RSpec.describe SalesEngine do
  before (:each) do
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoice_items => "./data/invoice_items.csv",
  :invoices => "./data/invoices.csv"
  })
  end

  it "exists" do
  expect(@se).to be_a(SalesEngine)
  end

  it "creates an instnace of items_repository class" do
    ir = @se.items

    expect(ir).to be_an_instance_of(ItemsRepository)
  end

  it "creates an instnace of merchants_repository class" do
    mr = @se.merchants

    expect(mr).to be_an_instance_of(MerchantsRepository)
  end

  it "creates an instance of invoice_items class" do
    invoice_items_repo = @se.invoice_items_repo

    expect(invoice_items_repo).to be_an_instance_of(InvoiceItemsRepository)
  end

end #RSpec end
