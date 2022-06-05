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
    expect(invoice_repo.find_all_by_customer_id(1)).to be_instance_of(Array)
    expect(invoice_repo.find_all_by_customer_id(1).length).to eq(8)
    expect(invoice_repo.find_all_by_customer_id(12345678910112)).to eq([])
  end

  it "can find all invoices by a matching merchant id" do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    expect(invoice_repo.find_all_by_merchant_id(12335938)).to be_instance_of(Array)
    expect(invoice_repo.find_all_by_merchant_id(12335938).length).to eq(16)
    expect(invoice_repo.find_all_by_merchant_id(12345678910112)).to eq([])
  end

  it 'can find all invoices by a matching status' do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    expect(invoice_repo.find_all_by_status("shipped")).to be_a(Array)
    expect(invoice_repo.find_all_by_status("returned")).to be_a(Array)
    expect(invoice_repo.find_all_by_status("pending")).to be_a(Array)
    expect(invoice_repo.find_all_by_status("super cool status")).to eq([])
  end

  it 'can create an invoice instance with provided attributes' do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    new_invoice_attributes = {:customer_id => "1000",
    :merchant_id => "12334372"}
    new_invoice = (invoice_repo.create(new_invoice_attributes))
    expect(new_invoice.customer_id).to eq("1000")
    expect(new_invoice.merchant_id).to eq("12334372")
    expect(invoice_repo.find_all_by_merchant_id(12334372)).to be_a(Array)
  end

  it 'can update an invoices attributes' do
    invoice_repo = InvoiceRepository.new('./data/invoices.csv')
    new_invoice_attributes = {:customer_id => "1000",
    :merchant_id => "12334372"}
    new_invoice = (invoice_repo.create(new_invoice_attributes))

    expect(invoice_repo.find_by_id(4986).customer_id).to eq("1000")
    expect(invoice_repo.find_by_id(4986).merchant_id).to eq("12334372")
    expect(invoice_repo.find_by_id(4986).status).to eq("pending")

    new_test_attributes = {:status => "shipped"}
    invoice_repo.update(4986, new_test_attributes)

    expect(invoice_repo.find_by_id(4986).customer_id).to eq("1000")
    expect(invoice_repo.find_by_id(4986).merchant_id).to eq("12334372")
    expect(invoice_repo.find_by_id(4986).status).to eq("shipped")
    expect(invoice_repo.find_by_id(4986).updated_at).to be_instance_of(Time)
  end

end
