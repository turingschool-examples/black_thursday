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
  expect(@repo.find_by_id(1).merchant_id).to eq(12335938)
  expect(@repo.find_by_id(200)).to eq(nil)
  expect(@repo.find_by_id(3).merchant_id).to eq(12335955)
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

    expect(invoice_id).to eq([3, 13])

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

      updated_all = []
      @repo.all.each do |invoice|
        updated_all << invoice.merchant_id
      end
        expect(updated_all).to eq([101, 103])
  end

  it 'shows invoices grouped by merchant' do
    customer_id = []
    @repo.invoices_by_merchant.each do |merchant, invoice|
      customer_id << invoice.customer_id
    end

    expect(customer_id).to eq([])
  end

  it 'shows invoice per merchants' do
    expect(@repo.invoices_per_merchant).to eq(12.2)
  end

  it 'shows total invoice by merchant' do
    expect(@repo.invoice_status(:pending)).to eq(33.33)
  end

end
