require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'CSV'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe InvoiceRepository do

  before(:each) do
    @invoice_repo = InvoiceRepository.new('./data/invoices.csv')
  end

  it 'exists' do
    expect(@invoice_repo).to be_a(InvoiceRepository)
  end

  it '#initialize' do
    expect(@invoice_repo.filename).to eq('./data/invoices.csv')
  end

  it 'can read #items' do

    expect(@invoice_repo.invoices).to be_a(Array)
  end

  it '#all' do
    expect(@invoice_repo.all).to be_a(Array)
  end

  it '#rows' do
    expect(@invoice_repo.rows).to be_a(CSV::Table)
  end

  it 'can #find_by_id(id)' do
    expect(@invoice_repo.find_by_id(3452)).to be_a(Invoice)
    expect(@invoice_repo.find_by_id(8888)).to eq(nil)
  end

  it 'can #find_all_by_customers_id(id)' do
    expect(@invoice_repo.find_all_by_customers_id(1)).to be_a(Array)
    expect(@invoice_repo.find_all_by_customers_id(300).count).to eq(10)
    expect(@invoice_repo.find_all_by_customers_id(8888)).to eq([])
  end

  it 'can #find_all_by_merchant_id(id)' do
    expect(@invoice_repo.find_all_by_merchant_id(12335955)).to be_a(Array)
    expect(@invoice_repo.find_all_by_merchant_id(12335080).count).to eq(7)
    expect(@invoice_repo.find_all_by_merchant_id(8888)).to eq([])
  end

  it 'can #find_all_by_status(id)' do
    expect(@invoice_repo.find_all_by_status(:returned)).to be_a(Array)
    expect(@invoice_repo.find_all_by_status(:shipped).count).to eq(2839)
    expect(@invoice_repo.find_all_by_status(:pending).count).to eq(1473)
    expect(@invoice_repo.find_all_by_status(:not_a_thing)).to eq([])
  end



end
