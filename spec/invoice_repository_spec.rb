require_relative 'spec_helper'
require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  before :each do
    @repo = InvoiceRepository.new('./spec/fixtures/mock_invoices.csv')
  end

  it 'exists' do
    expect(@repo).to be_an_instance_of(InvoiceRepository)
  end

  it 'can create invoice instances' do
    @repo.all.each do |invoice|
      expect(invoice).to be_an_instance_of(Invoice)
    end
  end

  it 'can find an invoice by id' do
  expect(@repo.find_by_id(1).merchant_id).to eq(11111)
  expect(@repo.find_by_id(200)).to eq(nil)
  expect(@repo.find_by_id(3).merchant_id).to eq(33333)
  end

  it 'can find all invoices by customer id' do
    merchant_id = []
    @repo.find_all_by_customer_id(7).each do |invoice|
      merchant_id << invoice.merchant_id
    end

    expect(merchant_id).to eq([12334861, 12334208, 12335417, 12336821])

    expect(@repo.find_all_by_customer_id(200)).to eq([])
  end

  it 'can find all invoices by merchant id' do
    invoice_id = []
    @repo.find_all_by_merchant_id(12335955).each do |invoice|
      invoice_id << invoice.id
    end

    expect(invoice_id).to eq([13])

    expect(@repo.find_all_by_merchant_id(200)).to eq([])
  end

  it 'can find all invoices by merchant id' do
    invoice_id = []
    @repo.find_all_by_status(:returned).each do |invoice|
      invoice_id << invoice.id
    end
    expect(invoice_id).to eq([25, 37, 49])

    expect(@repo.find_all_by_status(:sent)).to eq([])
  end

  it 'creates the next highest invoice id' do
    expect(@repo.next_highest_id).to eq(51)
  end

  it 'can create a new invoice' do
    attributes = {
      :customer_id => 2,
      :merchant_id => 104,
      :status      => "pending"
    }

    @repo.create(attributes)

    expect(@repo.all.length).to eq(51)
    expect(@repo.find_by_id(51).customer_id).to eq(2)
    expect(@repo.find_by_id(51).merchant_id).to eq(104)
    expect(@repo.find_by_id(51).status).to eq(:pending)
  end

  it 'can only update status and nothing else' do
    attributes_1 = {status: :shipped}

    @repo.update(1, attributes_1)

    expect(@repo.find_by_id(1).status).to eq(:shipped)

    attributes_2 = {
      id: 50,
      customer_id: 22,
      merchant_id: 200,
      created_at: Time.now
    }

  end

  it 'can delete the invoice by id' do
    @repo.delete(2)

    expect(@repo.all.length).to eq(49)
    expect(@repo.find_by_id(2)).to eq(nil)
  end

  xit 'shows invoices grouped by merchant' do
    customer_id = []
    @repo.group_invoices_by_merchant.each do |merchant, invoice|
      customer_id << invoice
    end

    expect(customer_id).to eq([])
  end

  it 'returns invoice count per merchants' do
    expect(@repo.invoices_per_merchant[5]).to eq(1)
  end

  it 'returns the number of merchants'do
    expect(@repo.number_of_merchants).to eq(48)
  end

  it 'returns total number of invoices' do
    expect(@repo.total_invoices).to eq(50)
  end

  xit 'groups invoices by created date' do
    expect(@repo.group_invoices_by_created_date).to eq()
  end

  it 'returns array of invoice per day' do
    expect(@repo.invoices_per_day.length).to eq(7)
  end

  xit 'returns invoice count per day created' do
    expect(@repo.invoices_by_created_date.keys).to eq(String)
  end

  it 'returns total invoice per status' do
    expect(@repo.invoice_status_total(:pending)).to eq(17)
  end
end
