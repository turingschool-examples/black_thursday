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
    expect(invr.find_all_by_customer_id(1)).to eq(
      [invr.invoice_instance_array[0],
      invr.invoice_instance_array[1], 
      invr.invoice_instance_array[2],
      invr.invoice_instance_array[3],
      invr.invoice_instance_array[4],
      invr.invoice_instance_array[5],
      invr.invoice_instance_array[6],
      invr.invoice_instance_array[7]]
    )
  end

end
