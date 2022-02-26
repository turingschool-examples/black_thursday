require 'rspec'
require 'csv'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  before (:each) do
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoice_items => "./data/invoice_items.csv",
  :invoices => "./data/invoices.csv",
  :customers => "./data/customers.csv",
  :transactions => "./data/transactions.csv"
  })
  end

  it "exists" do
  expect(@se).to be_a(SalesEngine)
  end

  it "creates an instance of items_repository class" do
    ir = @se.items
    item = ir.repository.sample
    mr = @se.merchants

    expect(ir).to be_an_instance_of(ItemsRepository)
    expect(item).to be_a(Item)
  end

  it "creates an instance of merchants_repository class" do
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

  it 'creates an instance of customer repository class' do
    cr = @se.customers
    expect(cr).to be_an_instance_of(CustomerRepository)
  end

  it 'creates an instance of transaction repository class' do
    tr = @se.transactions
    expect(tr).to be_an_instance_of(TransactionRepository)
  end
end #RSpec end
