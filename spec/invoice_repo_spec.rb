require 'Rspec'
require_relative '../lib/invoice_repo'

describe InvoiceRepo do
  before :each do
    @invoice_repo = InvoiceRepo.new('./data/invoices.csv')
  end

  it 'exists' do
    expect(@invoice_repo).to be_an_instance_of(InvoiceRepo)
  end

  it '#all' do

    expect(@invoice_repo.all).to be_an(Array)
  end

  it '#find_by_id' do
    expect(@invoice_repo.find_by_id(1).merchant_id).to eq(12335938)
  end

  it '#find_all_by_customer_id' do
    expect(@invoice_repo.find_all_by_customer_id(-1)).to eq []
    expect(@invoice_repo.find_all_by_customer_id(1).length).to eq 8
  end

  it '#find_all_by_merchant_id' do
    expect(@invoice_repo.find_all_by_merchant_id(-1)).to eq []
    expect(@invoice_repo.find_all_by_merchant_id(12336642).length).to eq 7
  end

  it '#find_all_by_status' do
    expect(@invoice_repo.find_all_by_status('burned to a crisp')).to eq([])
    expect(@invoice_repo.find_all_by_status(:pending).length).to eq(1473)
  end

  it '#create(attributes)' do
    @invoice_repo.create({
                          status: 'pending',
                          customer_id: 1,
                          merchant_id: 12336652
                          })
    expect(@invoice_repo.all.last.merchant_id).to eq(12336652)
    expect(@invoice_repo.all.last.id).to eq(4986)
  end

  it '#update(attributes)' do
    @invoice_repo.create({
                status: 'pending',
                customer_id: 1,
                merchant_id: 12336652
                })
    @invoice_repo.update(4986, {:status => 'shipped'})
    expect(@invoice_repo.find_by_id(4986).status).to eq('shipped')
  end

  it '#delete(id)' do
    @invoice_repo.create({
                status: 'pending',
                customer_id: 1,
                merchant_id: 12336652
                })
    @invoice_repo.delete(4986)

    expect(@invoice_repo.find_by_id(4986)).to eq(nil)
  end
end
