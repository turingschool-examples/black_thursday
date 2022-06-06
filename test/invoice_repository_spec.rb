require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/invoice'
require './lib/invoice_repository'

describe InvoiceRepository do
  let(:sales_engine) {SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })}
  let(:invoice) {sales_engine.invoices}


  it "exists" do
    expect(invoice).to be_an(InvoiceRepository)
  end

  it "has attributes" do
    expect(invoice.all).to be_an(Array)
    expect(invoice.all.first.merchant_id).to eq(12335938)
    expect(invoice.all.first.status).to eq(:pending)
    expect(invoice.all.length).to eq(4985)
  end

  it "can find an invoice by id" do
    expect(invoice.find_by_id(1).merchant_id).to eq(12335938)
    expect(invoice.find_by_id(5000)).to eq(nil)
  end

  it "can find an invoice by customer id" do
    expect(invoice.find_all_by_customer_id(2)).to be_a(Array)
    expect(invoice.find_all_by_customer_id(2).count).to eq(4)
    expect(invoice.find_all_by_customer_id(5000)).to eq([])
  end

  it 'Can find all by merchant id' do
    expect(invoice.find_all_by_merchant_id(12334141)).to be_a(Array)
    expect(invoice.find_all_by_merchant_id(12334141).length).to eq(18)
    expect(invoice.find_all_by_merchant_id(12334141345436)).to eq([])
  end

  it 'Can find all by status' do
    expect(invoice.find_all_by_status(:pending)).to be_a(Array)
    expect(invoice.find_all_by_status(:shipped).length).to eq(2839)
    expect(invoice.find_all_by_status(:returned).length).to eq(673)
  end

  it 'can create a new invoice' do
    attributes = {
        :id => 4986,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      }
    invoice.create(attributes)
    expect(invoice.all.length).to eq(4986)
  end

  it 'can update an invoice' do
    attributes = {
        :status      => "missing",
      }
    expect(invoice.all.last.status).to eq(:shipped)
    invoice.update(4985, attributes)
    expect(invoice.all.last.status).to eq("missing")
  end

  it 'can delete by id' do
    invoice.delete(300)
    expect(invoice.all.length).to eq(4984)
    expect(invoice.find_by_id(300)).to eq(nil)
  end


end
