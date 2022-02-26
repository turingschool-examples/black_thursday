require 'RSpec'
require 'SimpleCov'
require_relative '../lib/invoice.rb'
require_relative '../lib/invoice_repository.rb'
require_relative '../lib/sales_engine.rb'
SimpleCov.start

RSpec.describe InvoiceRepository do
  # declares variables to be used by following tests
  invoice_1 = Invoice.new({ id: 1, customer_id: 2307, merchant_id: 24601, status: :pending, created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
  invoice_2 = Invoice.new({ id: 2, customer_id: 2307, merchant_id: 9000, status: :shipped, created_at: "2002-02-14 03:42:01.825489", updated_at: "2022-02-26 04:05:10 UTC"})
  invoice_3 = Invoice.new({ id: 3, customer_id: 76, merchant_id: 9000, status: :pending, created_at: "2020-01-25 08:13:45.246743", updated_at: "2020-01-27 14:22:45.246743"})
  invoice_repo = InvoiceRepository.new([invoice_1, invoice_2, invoice_3])

  # resets each of these variables before each test,
  # in case the last tests manipulated them
  before(:each) do
    invoice_1 = Invoice.new({ id: 1, customer_id: 2307, merchant_id: 24601, status: :pending, created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    invoice_2 = Invoice.new({ id: 2, customer_id: 2307, merchant_id: 9000, status: :shipped, created_at: "2002-02-14 03:42:01.825489", updated_at: "2022-02-26 04:05:10 UTC"})
    invoice_3 = Invoice.new({ id: 3, customer_id: 76, merchant_id: 9000, status: :pending, created_at: "2020-01-25 08:13:45.246743", updated_at: "2020-01-27 14:22:45.246743"})
    invoice_repo = InvoiceRepository.new([invoice_1, invoice_2, invoice_3])
  end

  it 'initializes from an array of Invoice instances' do
    expect(invoice_repo).to be_a(InvoiceRepository)
  end

  it 'finds a specific invoice by ID' do
    expect(invoice_repo.find_by_id(1)).to eq(invoice_1)
    expect(invoice_repo.find_by_id(2)).to eq(invoice_2)
    expect(invoice_repo.find_by_id(3)).to eq(invoice_3)
  end

  it 'finds all invoices by a specific customer ID' do
    expect(invoice_repo.find_all_by_customer_id(2307)).to eq([invoice_1, invoice_2])
    expect(invoice_repo.find_all_by_customer_id(76)).to eq([invoice_3])
    expect(invoice_repo.find_all_by_customer_id(2)).to eq([])
  end

  it 'finds all invoices by a specific merchant ID' do
    expect(invoice_repo.find_all_by_merchant_id(24601)).to eq([invoice_1])
    expect(invoice_repo.find_all_by_merchant_id(9000)).to eq([invoice_2, invoice_3])
    expect(invoice_repo.find_all_by_merchant_id(13)).to eq([])
  end

  it 'finds all invoice instances by similar status' do
    expect(invoice_repo.find_all_by_status(:pending)).to eq([invoice_1, invoice_3])
    expect(invoice_repo.find_all_by_status(:shipped)).to eq([invoice_2])
    expect(invoice_repo.find_all_by_status(:processing)).to eq([]) # because covid, obviously
  end

  it 'can create new invoices via the #create method' do
    invoice_repo.create({customer_id: 47, merchant_id: 13, status: :received})
    expect(invoice_repo.all.length).to eq(4)
    expect(invoice_repo.all.last).to be_a(Invoice)
    expect(invoice_repo.all.last.id).to eq(4)
    expect(invoice_repo.all.last.created_at).to be_truthy
    expect(invoice_repo.all.last.updated_at).to be_truthy
  end

  it 'can update existing invoices via #update(id, :status_symbol)' do
    invoice_repo.update(3, :shipped)

    expect((invoice_repo.find_by_id(3)).status).to eq(:shipped)
    expect((invoice_repo.find_by_id(3)).updated_at).not_to eq("2020-01-27 14:22:45.246743")
  end

  it 'can delete an invoice from its library by #delete(id)' do
    invoice_repo.delete(2)
    expect(invoice_repo.all).to eq([invoice_1, invoice_3])
    invoice_repo.delete(1)
    expect(invoice_repo.all).to eq([invoice_3])
    invoice_repo.delete(3)
    expect(invoice_repo.all).to eq([])
  end

  it 'initializes from SalesEngine#invoices()' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    invoice_repo = se.invoices
    expect(invoice_repo).to be_a(InvoiceRepository) #Test basic initialization
    expect(invoice_repo.find_by_id(521)).to be_a(Invoice)
    expect((invoice_repo.find_by_id(521)).status).to eq(:returned)
  end
end
