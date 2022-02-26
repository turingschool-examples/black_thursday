require 'rspec'
require 'csv'
require './lib/sales_engine'

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
    item = ir.repository.sample
    mr = @se.merchants
    require 'pry'; binding.pry
    expect(ir).to be_an_instance_of(ItemsRepository)
    expect(item).to be_a(Item)
  end

  it "creates an instnace of merchants_repository class" do
    mr = @se.merchants
    merchant = mr.find_by_name("CJsDecor")

    expect(mr).to be_an_instance_of(MerchantsRepository)
    expect(merchant).to be_a(Merchant)
  end

  it "creates an instance of invoice_items class" do
    invoice_items_repo = @se.invoice_items_repo

    expect(invoice_items_repo).to be_an_instance_of(InvoiceItemsRepository)
  end

  it "creates an instance of invoice_repository class" do
    ir = @se.invoices

    expect(ir).to be_an_instance_of(InvoiceRepository)
  end

end #RSpec end
