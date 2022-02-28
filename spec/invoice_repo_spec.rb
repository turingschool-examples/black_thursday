require "./spec/spec_helper"
require "./lib/invoice_repo"
require "./lib/sales_engine"
require "./lib/invoice"
require "pry"

RSpec.describe InvoiceRepository do
  se = SalesEngine.from_csv({
    items: "./data/items.csv",
    merchants: "./data/merchants.csv",
    invoices: "./data/invoices.csv"
  })

  invr = InvoiceRepository.new(se.invoices_instanciator)

  it 'exists' do
    expect(invr).to be_an_instance_of(InvoiceRepository)
  end

  it 'returns invoice_instance_array when #all is called' do
    expect(invr.all).to eq(se.invoices_instances_array)
  end

  it 'can find an invoice by id using #find_by_id' do
    expect(invr.find_by_id(6)).to eq(invr.invoice_instance_array[5])
  end

  it 'can find all invoices by customer id' do
    expect(invr.find_all_by_customer_id(1).length).to eq(8)
    expect(invr.find_all_by_customer_id(1000).length).to eq(0)
  end

  it 'can find all invoices by merchant id' do
    expect(invr.find_all_by_merchant_id(12335080).length).to eq(7)
    expect(invr.find_all_by_merchant_id(1000).length).to eq(0)
  end

  it 'can find all invoices by status' do
    expect(invr.find_all_by_status(:shipped).length).to eq(2839)
    expect(invr.find_all_by_status(:pending).length).to eq(1473)
    expect(invr.find_all_by_status(:sold).length).to eq(0)
  end

  it 'creates new invoices' do
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status => "pending",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    invr.create(attributes)
    expect(invr.find_by_id(4986).invoice_attributes[:merchant_id]).to eq(8)
  end

  it 'updates existing invoices' do
    time = invr.find_by_id(4986).invoice_attributes[:updated_at]
    attributes = {:status => :sold}
    invr.update(4986, attributes)
    expect(invr.find_by_id(4986).invoice_attributes[:status]).to eq(:sold)
    expect(invr.find_by_id(4986).invoice_attributes[:updated_at]).to_not eq(time)
  end
end
